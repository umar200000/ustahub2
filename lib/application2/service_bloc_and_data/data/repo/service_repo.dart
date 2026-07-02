import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class ServiceRepo {
  final _dio = sl<Dio>();

  Future<Response> getServices({
    int skip = 0,
    int limit = 2,
    double? latitude,
    double? longitude,
  }) async {
    if (latitude != null && longitude != null) {
      final response = await _dio.post(
        "api/v1/client/services/search/",
        data: {
          "skip": skip,
          "limit": limit,
          "latitude": latitude,
          "longitude": longitude,
          "sort_by": "distance",
        },
      );
      return response;
    }

    final response = await _dio.get(
      "api/v1/client/services/",
      queryParameters: {"skip": skip, "limit": limit},
    );
    return response;
  }
}
