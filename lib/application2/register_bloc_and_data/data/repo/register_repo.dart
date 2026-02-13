import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class RegisterRepo {
  final _dio = sl<Dio>();

  Future<Map<String, dynamic>> visiteGuest() async {
    final response = await _dio.post("api/v1/client/auth/guest/");
    return response.data;
  }

  // Future<Map<String, dynamic>> getToken({required String refreshToken}) async {
  //   final response = await _dio.post(
  //     "/api/v1/auth/refresh",
  //     data: {"refresh_token": refreshToken},
  //   );
  //   return response.data;
  // }

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await _dio.get("api/v1/client/auth/me/");
    return response.data;
  }

  Future<Map<String, dynamic>> completeRegistration({
    required String phone,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
  }) async {
    final response = await _dio.post(
      "api/v1/client/auth/register/complete/",
      data: {
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> userProfileUbdate({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final response = await _dio.patch(
      "api/v1/client/auth/profile/",
      data: {"first_name": firstName, "last_name": lastName, "email": email},
    );

    return response.data;
  }
}
