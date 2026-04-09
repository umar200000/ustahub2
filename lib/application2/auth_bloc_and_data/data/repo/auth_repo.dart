import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../infrastructure2/init/injection.dart';

class AuthRepo {
  final _dio = sl<Dio>();

  Future<Response> requestOtp(String phoneNumber) async {
    return await _dio.post(
      "api/v1/client/auth/otp/request/",
      data: {"phone": phoneNumber},
    );
  }

  Future<Response> verifyOtp(String phoneNumber, String code) async {
    String? deviceToken;
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (_) {}

    final String deviceType = Platform.isAndroid
        ? "android"
        : Platform.isIOS
            ? "ios"
            : "web";

    return await _dio.post(
      "api/v1/client/auth/otp/verify/",
      data: {
        "phone": phoneNumber,
        "code": code,
        "device_token": deviceToken ?? "",
        "device_type": deviceType,
      },
    );
  }
}
