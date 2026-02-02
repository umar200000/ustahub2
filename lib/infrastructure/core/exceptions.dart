import 'package:chopper/chopper.dart';
import 'package:easy_localization/easy_localization.dart';

class NetworkException implements Exception {
  final message = "connection_is_afk".tr();

  @override
  String toString() => message;
}

class BackendException implements Exception {
  final message = "backend_exception".tr();

  @override
  String toString() => message;
}

class BackendExceptionForSentry implements Exception {
  final Response response;

  BackendExceptionForSentry(this.response);

  @override
  String toString() => "API Error: ${response.base.request?.url} "
      "Status Code: ${response.statusCode} "
      "Response: ${response.body} "
      "Headers: ${response.headers} ";
}
