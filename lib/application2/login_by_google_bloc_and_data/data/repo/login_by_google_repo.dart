import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class LoginByGoogleRepo {
  final _dio = sl<Dio>();

  Future<Map<String, dynamic>> requestOtp({
    required String idToken,
    required String devicToken,
    required String devicType,
  }) async {
    final response = await _dio.post(
      "api/v1/client/auth/google/",
      data: {
        "id_token": idToken,
        "device_token": devicToken,
        "device_type": devicType,
      },
    );

    return response.data;
  }
}
