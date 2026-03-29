import "package:dio/dio.dart";

import "error_helper.dart";

/// Bu klass [DioException] ni kengaytiradi va server xatolarini
/// markaziy error_helper orqali qaytaradi.
class DioExceptionX extends DioException {
  DioExceptionX({
    required super.requestOptions,
    dynamic super.error,
    this.statusCode,
    this.serverError,
    this.checkUnauthorized = true,
    this.errorType = DioExceptionType.unknown,
  }) : super(type: errorType);

  final int? statusCode;
  final dynamic serverError;
  final bool checkUnauthorized;
  final DioExceptionType errorType;

  @override
  String toString() {
    if (error != null) {
      return error.toString();
    }
    return _getServerError();
  }

  String _getServerError() {
    try {
      if (statusCode != null && statusCode! >= 500) {
        return "Server bilan bog’lanishda xatolik";
      }

      if (checkUnauthorized && statusCode == 401) {
        return extractFromResponseData(
          serverError,
          fallback: "Avtorizatsiya xatosi",
        );
      }

      if (statusCode == 422) {
        return extractFromResponseData(
          serverError,
          fallback: "Ma’lumotlar noto’g’ri kiritilgan",
        );
      }

      return extractFromResponseData(serverError);
    } catch (_) {
      return "Xatolik yuz berdi";
    }
  }
}
