import 'dart:io'; 

import 'package:dio/dio.dart'; 
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../infrastructure/services/shared_perf/shared_pref_service.dart';
import '../init/injection.dart';
import 'api_path.dart';
import 'interceptor.dart'; 

Dio createDio() {
  final dio = Dio();

  return dio
    ..interceptors.addAll([
      DioInterceptor(),

      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token =
              sl<SharedPrefService>().getTokenModel()?.accessToken ?? "";

          options.headers['Accept-Language'] = sl<SharedPrefService>()
              .getLanguageCode(); 

          if (token.isNotEmpty) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),

      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
        filter: (options, args) {
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    ])
    ..options = BaseOptions(
      baseUrl: baseUrl, 
      connectTimeout: const Duration(minutes: 1), 
      receiveTimeout: const Duration(seconds: 40), 
      sendTimeout: const Duration(seconds: 30), 
      // 400+ statuslar endi Exception (onError) deb hisoblanadi
      validateStatus: (status) => status != null && status < 400,

      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
}
