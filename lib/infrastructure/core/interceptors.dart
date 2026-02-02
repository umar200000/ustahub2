import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:io' show HttpHeaders;

import 'package:chopper/chopper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:ustahub/domain/common/token_ext.dart';
import 'package:ustahub/infrastructure/services/alice/core/alice_adapter.dart';
import 'package:ustahub/infrastructure/services/alice/core/alice_utils.dart';
import 'package:ustahub/infrastructure/services/alice/model/alice_http_call.dart';
import 'package:ustahub/infrastructure/services/alice/model/alice_http_error.dart';
import 'package:ustahub/infrastructure/services/alice/model/alice_http_request.dart';
import 'package:ustahub/infrastructure/services/alice/model/alice_http_response.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';

import '../services/connectivity.dart';
import 'exceptions.dart';

class AliceChopperAdapter with AliceAdapter implements Interceptor {
  /// Creates hashcode based on request
  int getRequestHashCode(http.BaseRequest baseRequest) {
    final int hashCodeSum =
        baseRequest.url.hashCode +
        baseRequest.method.hashCode +
        baseRequest.headers.entries.fold<int>(
          0,
          (int previousValue, MapEntry<String, String> header) =>
              previousValue + header.key.hashCode + header.value.hashCode,
        ) +
        (baseRequest.contentLength?.hashCode ?? 0);

    return hashCodeSum.hashCode;
  }

  /// Handles chopper request and creates alice http call
  @override
  FutureOr<Response<T>> intercept<T>(Chain<T> chain) async {
    final int requestId = getRequestHashCode(
      /// The alice_token header is added to the request in order to keep track
      /// of the request in the AliceCore instance.
      applyHeader(chain.request, 'alice_token', const Uuid().v4()),
    );
    aliceCore.addCall(
      AliceHttpCall(requestId)
        ..method = chain.request.method
        ..endpoint = chain.request.url.path.isEmpty
            ? '/'
            : chain.request.url.path
        ..server = chain.request.url.host
        ..secure = chain.request.url.scheme == 'https'
        ..uri = chain.request.url.toString()
        ..client = 'Chopper'
        ..request = (AliceHttpRequest()
          ..size = switch (chain.request.body) {
            dynamic body when body is String => utf8.encode(body).length,
            dynamic body when body is List<int> => body.length,
            dynamic body when body == null => 0,
            _ => utf8.encode(body.toString()).length,
          }
          ..body = chain.request.body ?? ''
          ..time = DateTime.now()
          ..headers = chain.request.headers
          ..contentType =
              chain.request.headers[HttpHeaders.contentTypeHeader] ?? 'unknown'
          ..queryParameters = chain.request.parameters)
        ..response = AliceHttpResponse(),
    );
    try {
      final Response<T> response = await chain.proceed(chain.request);
      aliceCore.addResponse(
        AliceHttpResponse()
          ..status = response.statusCode
          ..body = response.body ?? ''
          ..size = switch (response.body) {
            dynamic body when body is String => utf8.encode(body).length,
            dynamic body when body is List<int> => body.length,
            dynamic body when body == null => 0,
            _ => utf8.encode(body.toString()).length,
          }
          ..time = DateTime.now()
          ..headers = <String, String>{
            for (final MapEntry<String, String> entry
                in response.headers.entries)
              entry.key: entry.value,
          },
        requestId,
      );

      if (!response.isSuccessful || response.error != null) {
        aliceCore.addError(AliceHttpError()..error = response.error, requestId);
      }

      return response;
    } catch (error, stackTrace) {
      AliceUtils.log(error.toString());

      aliceCore.addResponse(AliceHttpResponse(), requestId);

      /// Add error to Alice core
      if (error is BackendExceptionForSentry) {
        Response response = error.response;
        aliceCore.addResponse(
          AliceHttpResponse()
            ..status = response.statusCode
            ..body = response.body ?? ''
            ..size = switch (response.body) {
              dynamic body when body is String => utf8.encode(body).length,
              dynamic body when body is List<int> => body.length,
              dynamic body when body == null => 0,
              _ => utf8.encode(body.toString()).length,
            }
            ..time = DateTime.now()
            ..headers = <String, String>{
              for (final MapEntry<String, String> entry
                  in response.headers.entries)
                entry.key: entry.value,
            },
          requestId,
        );
      } else {
        aliceCore.addError(
          AliceHttpError()
            ..error = error
            ..stackTrace = stackTrace,
          requestId,
        );
      }

      /// Rethrow error
      rethrow;
    }
  }
}

class NetworkInterceptor implements Interceptor {
  @override
  FutureOr<Response<T>> intercept<T>(Chain<T> chain) async {
    final connectivity = await ConnectivityX().create();

    if (!connectivity) {
      throw NetworkException();
    }
    return chain.proceed(chain.request);
  }
}

class BackendInterceptor implements Interceptor {
  @override
  FutureOr<Response<T>> intercept<T>(Chain<T> chain) async {
    final response = await chain.proceed(chain.request);
    if (response.statusCode >= 500) {
      throw BackendException();
    }
    return response;
  }
}

class CoreInterceptor implements Interceptor {
  final DBService dbService;

  CoreInterceptor(this.dbService);

  @override
  FutureOr<Response<T>> intercept<T>(Chain<T> chain) async {
    var request = chain.request;
    request = applyHeader(request, 'Accept-Language', 'app_lang'.tr());
    request = applyHeader(request, 'Tenant', 'Sazu');

    // final request1 = applyHeader(request, 'uuid', dbService.getUid ?? "");

    final requiresToken =
        request.headers['requires-token'] == 'true' ||
        request.headers['requires-token'] == 'optional';

    if (requiresToken) {
      if (dbService.token.toBearerToken != null) {
        final request2 = applyHeader(
          request,
          'Authorization',
          dbService.token.toBearerToken!,
        );
        return chain.proceed(request2);
      } else {
        final requiresToken = request.headers['requires-token'] == 'optional';
        if (requiresToken) {
          return chain.proceed(request);
        } else {
          throw Exception('invalid_credential'.tr());
        }
      }
    }

    return chain.proceed(request);
  }
}

class RetryInterceptor implements Interceptor {
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  FutureOr<Response<T>> intercept<T>(Chain<T> chain) async {
    final request = chain.request;
    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        return chain.proceed(request);
      } catch (e) {
        if (attempt < maxRetries - 1) {
          await Future.delayed(retryDelay);
        } else {
          rethrow;
        }
      }
    }
    return chain.proceed(request);
  }
}

class TimeoutHttpClient extends http.BaseClient {
  final http.Client _inner;
  final Duration timeout;

  TimeoutHttpClient(this._inner, {required this.timeout});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request).timeout(timeout);
  }
}
