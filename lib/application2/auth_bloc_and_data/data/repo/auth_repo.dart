import 'package:dio/dio.dart';

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
    return await _dio.post(
      "api/v1/client/auth/otp/verify/",
      data: {"phone": phoneNumber, "code": code},
    );
  }
}
