import 'package:dio/dio.dart';

/// API dan keladigan error message ni to'g'ri parse qiladi.
///
/// API response formati:
/// ```json
/// {
///   "success": false,
///   "message": "Xatolik haqida xabar",
///   "error": {
///     "code": "ERROR_CODE",
///     "message": "Batafsil xato xabari"
///   }
/// }
/// ```
String extractErrorMessage(dynamic error, {String fallback = "Xatolik yuz berdi"}) {
  if (error is DioException) {
    return _extractFromDioException(error, fallback);
  }
  if (error is Exception || error is Error) {
    return error.toString();
  }
  return fallback;
}

String _extractFromDioException(DioException e, String fallback) {
  // Timeout xatoliklari
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout) {
    return "Server javob bermayapti, qaytadan urinib ko'ring";
  }

  // Internet yo'q
  if (e.type == DioExceptionType.connectionError) {
    return "Internet aloqasi yo'q";
  }

  // DioExceptionX (interceptor orqali kelgan) — to'g'ridan-to'g'ri toString() ishlatamiz
  // chunki u allaqachon serverdan kelgan xabarni parse qilgan
  if (e.toString() != 'null' && e.toString().isNotEmpty && e.toString() != e.runtimeType.toString()) {
    final msg = e.toString();
    // DioException: ... formatidan tozalash
    if (!msg.startsWith('DioException')) {
      return msg;
    }
  }

  // Response data dan parse qilish
  final data = e.response?.data;
  if (data != null) {
    return _extractFromResponseData(data, fallback);
  }

  return e.message ?? fallback;
}

/// API response body dan error message ni olish.
/// Ikki formatni qo'llab-quvvatlaydi:
/// 1. { "error": { "message": "..." } }
/// 2. { "message": "..." }
/// 3. { "error": { "field_name": ["error msg"] } } (validation)
String extractFromResponseData(dynamic data, {String fallback = "Xatolik yuz berdi"}) {
  return _extractFromResponseData(data, fallback);
}

String _extractFromResponseData(dynamic data, String fallback) {
  if (data is Map<String, dynamic>) {
    // 1. error.message
    if (data['error'] != null) {
      final error = data['error'];
      if (error is Map<String, dynamic>) {
        if (error['message'] != null) {
          return error['message'].toString();
        }
        // Validation errors: { "phone": ["Bu telefon..."] }
        if (error.isNotEmpty) {
          final firstKey = error.keys.first;
          final value = error[firstKey];
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
          if (value is String) {
            return value;
          }
        }
      }
      if (error is String) {
        return error;
      }
    }

    // 2. message
    if (data['message'] != null) {
      return data['message'].toString();
    }

    // 3. detail (ba'zi API lar uchun)
    if (data['detail'] != null) {
      return data['detail'].toString();
    }
  }

  if (data is String && data.isNotEmpty) {
    return data;
  }

  return fallback;
}
