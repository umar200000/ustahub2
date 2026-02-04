import 'package:dio/dio.dart';
import '../../../../infrastructure2/init/injection.dart';

class RegisterRepo {
  final _dio = sl<Dio>();

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
      // 400, 401, 500 kabi xatolarda Exception tashlamasligi uchun:
      options: Options(validateStatus: (status) => true),
    );

    return response.data;
  }
}
