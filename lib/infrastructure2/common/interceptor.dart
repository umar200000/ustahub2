import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'dio_exception.dart';

/*
  Bu Interceptor — har bir request/response/error oqimiga aralashib,
  xatoliklarni global darajada boshqaradi.
*/
class DioInterceptor extends Interceptor {
  DioInterceptor();

  Future<Object> getDeviceInfoData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return {
        'Model: ${androidInfo.model}',
        'Brand: ${androidInfo.brand}',
        'Android Version: ${androidInfo.version.release}',
        'Android ID: ${androidInfo.id}',
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      return {
        'Model: ${iosInfo.utsname.machine}',
        'System Name: ${iosInfo.systemName}',
        'System Version: ${iosInfo.systemVersion}',
        'Identifier for Vendor: ${iosInfo.identifierForVendor}',
      };
    }
    return {};
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // ✅ checkUnauthorized — token borligini tekshirish flag’i
    // Agar request header ichida `check_token` bo‘lmasa → Unauthorized deb olinadi
    final bool checkUnauthorized = !err.requestOptions.headers.containsKey(
      'check_token',
    );

    // 🔹 1. Agar backend 401 qaytarsa → foydalanuvchi tokeni noto‘g‘ri yoki muddati o‘tgan
    if (err.response?.statusCode == 401) {
      // Tokenni tozalash kerak bo‘lsa shu yerda yozish mumkin
      // Masalan: UserData.token = "";

      // Login sahifasiga qayta yo‘naltirish (navigatorKey orqali context o‘rniga ishlatiladi)
      // navigatorKey.currentState?.pushAndRemoveUntil(
      //   CupertinoPageRoute(builder: (_) => AuthPage()),
      //   (route) => false, // stackdagi barcha sahifalarni o‘chirib tashlaydi
      // );
    }
    // 🔹 2. Agar backend 310 qaytarsa → bu maxsus custom error
    else if (err.response?.statusCode == 310) {
      // Debug uchun log chiqarish
      debugPrint("⚠️ Custom error: ${err.response?.data['error']['message']}");

      // Istasa shu yerda SnackBar yoki Dialog chiqarish mumkin
      // ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(...)
    }

    // 🔹 3. Har doim xatolikni qayta ishlash va oldinga uzatish
    return handler.next(
      DioExceptionX(
        requestOptions: err.requestOptions, // Request ma’lumotlari
        statusCode: err.response?.statusCode, // HTTP status code
        serverError:
            err.response?.data ?? {}, // Serverdan qaytgan xato ma’lumoti
        errorType: err.type, // Xatolik turi (timeout, response error va h.k.)
        checkUnauthorized: checkUnauthorized, // Unauthorized flag’i
      ),
    );
  }
} // Custom Exception class (DioExceptionX)
