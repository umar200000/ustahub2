import 'dart:io'; // HttpHeaders uchun

import 'package:dio/dio.dart'; // Dio kutubxonasi
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../infrastructure/services/shared_perf/shared_pref_service.dart';
import '../init/injection.dart';
import 'api_path.dart';
import 'interceptor.dart'; // Biz yozgan custom DioInterceptor

/*
  Bu funksiya — Dio instance (obyekt) yaratadi va unga kerakli sozlamalarni beradi.
  Har doim bir xil sozlamalarda ishlatiladigan `dio` ni global qilib olish uchun yoziladi.
*/
Dio createDio() {
  // 🔹 Yangi Dio obyektini yaratamiz
  final dio = Dio();

  // 🔹 Interceptorlar qo‘shamiz
  return dio
    ..interceptors.addAll([
      DioInterceptor(),

      // 🔑 Token va Tilni qo‘shadigan interceptor
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token =
              sl<SharedPrefService>().getTokenModel()?.accessToken ?? "";

          // Tilni headerga qo'shib yuboramiz. Keyinchalik sozlamalardan olinadigan qilish mumkin.
          options.headers['Accept-Language'] = sl<SharedPrefService>()
              .getLanguageCode(); // 'uz', 'ru', 'en'

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
    // 🔹 Umumiy konfiguratsiyalar
    ..options = BaseOptions(
      baseUrl: baseUrl, // barcha requestlarga asosiy API URL qo‘shiladi
      // Timeout sozlamalari
      connectTimeout: const Duration(minutes: 1), // serverga ulanish muddati
      receiveTimeout: const Duration(seconds: 40), // javobni kutish muddati
      sendTimeout: const Duration(seconds: 30), // request yuborish muddati
      // 400, 401, 500 kabi xatolarda Exception tashlamasligi uchun:
      validateStatus: (status) => status != null && status < 500,

      // Default headerlar
      headers: {
        HttpHeaders.acceptHeader:
            'application/json', // serverdan JSON qabul qilamiz
        HttpHeaders.contentTypeHeader:
            'application/json', // serverga JSON yuboramiz
      },
    );
}
