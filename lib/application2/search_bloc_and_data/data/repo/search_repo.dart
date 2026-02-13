import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class SearchRepo {
  final _dio = sl<Dio>();

  Future<Response> getSearchList({
    required String query,
    int skip = 0,
    int limit = 20,
  }) async {
    final response = await _dio.get(
      "api/v1/client/services/",
      queryParameters: {"search": query, "skip": skip, "limit": limit},
    );
    return response;
  }
}
