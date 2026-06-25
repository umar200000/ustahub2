import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class SearchRepo {
  final _dio = sl<Dio>();

  Future<Response> getSearchList({
    required String query,
    int skip = 0,
    int limit = 20,
    String? provinceId,
    String? districtId,
    String? categoryId,
  }) async {
    final params = <String, dynamic>{
      "search": query,
      "skip": skip,
      "limit": limit,
    };
    if (provinceId != null) params["province_id"] = provinceId;
    if (districtId != null) params["district_id"] = districtId;
    if (categoryId != null) params["category_id"] = categoryId;
    final response = await _dio.get(
      "api/v1/client/services/",
      queryParameters: params,
    );
    return response;
  }
}
