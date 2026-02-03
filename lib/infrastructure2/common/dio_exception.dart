import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
/// Bu klass [DioException] ni kengaytiradi va server xatolarini
/// lokalizatsiya qilingan holda qaytaradi.
class DioExceptionX extends DioException {
  DioExceptionX({
    required super.requestOptions,
    dynamic super.error,
    this.statusCode,
    this.serverError,
    this.checkUnauthorized = true,
    this.errorType = DioExceptionType.unknown,
  }) : super(type: errorType);

  /// HTTP status code (masalan: 200, 401, 500)
  final int? statusCode;

  /// Serverdan kelgan xatolik ma’lumoti (response.data)
  final dynamic serverError;

  /// Unauthorized (401) holatni tekshirish flag’i
  final bool checkUnauthorized;

  /// Xatolik turi (timeout, response error, unknown va h.k.)
  final DioExceptionType errorType;

  @override
  String toString() {
    if (error != null) {
      // Agar Dio ichki error mavjud bo‘lsa, shuni qaytaramiz
      return error.toString();
    } else {
      // Aks holda server xatoliklarini qaytaramiz
      return _getServerError();
    }
  }

  /// Serverdan kelgan xatolikni qaytaruvchi metod
  String _getServerError() {
    try {
      if (checkUnauthorized && statusCode == 401) {
        // Unauthorized bo‘lsa (token noto‘g‘ri yoki muddati o‘tgan)
        if (serverError is Map && serverError['message'] != null) {
          return serverError['message'].toString();
        }
        return "Unauthorized kirish";
      } else if(statusCode == 422){
        if (serverError is Map && serverError['message'] != null) {
          return serverError['message'].toString();
        }
        return "Unauthorized kirish";
      }else {
        if (statusCode != null && statusCode! >= 500) {
          // Server errorlari (500+)
          return "Server bilan bog‘lanishda xatolik";
        } else if (serverError is Map<String, dynamic>) {
          // Agar serverdan JSON qaytsa
          final Map<String, dynamic> data = serverError;

          if (data['error'] != null && data['error'] is Map) {
            // Xato message ichidagi birinchi qiymatni olish
            final Map<String, dynamic> message = data['error'];
            return message[message.keys.first][0].toString();
          } else if (data['message'] != null) {
            return data['message'].toString();
          }
        }

        // Agar hech qaysi shartga tushmasa → oddiy toString()
        return serverError.toString();
      }
    } catch (e) {
      // Noma’lum xato
      return tr('errors.unknown');
    }
  }
}
