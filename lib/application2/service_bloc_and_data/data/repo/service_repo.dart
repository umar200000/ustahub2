import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class ServiceRepo {
  final _dio = sl<Dio>();

  Future<Response> getServices({int skip = 0, int limit = 2}) async {
    final response = await _dio.get(
      "api/v1/client/services/",
      queryParameters: {"skip": skip, "limit": limit},
    );
    return response;
  }
}
