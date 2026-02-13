import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class CategoryListRepo {
  final _dio = sl<Dio>();

  Future<Response> getCategoriesList({
    required String id,
    int skip = 0,
    int limit = 2,
  }) async {
    final response = await _dio.get(
      "api/v1/client/services/",
      queryParameters: {"category_id": id, "skip": skip, "limit": limit},
    );
    return response;
  }
}
