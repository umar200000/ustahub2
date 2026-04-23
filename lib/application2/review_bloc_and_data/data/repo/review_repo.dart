import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class ReviewRepo {
  final _dio = sl<Dio>();

  Future<Response> getServiceReviews({
    required String serviceId,
    int skip = 0,
    int limit = 20,
    int? ratingFilter,
  }) async {
    final queryParams = <String, dynamic>{
      "skip": skip,
      "limit": limit,
    };
    if (ratingFilter != null) {
      queryParams["rating_filter"] = ratingFilter;
    }
    final response = await _dio.get(
      "api/v1/client/reviews/service/$serviceId/",
      queryParameters: queryParams,
    );
    return response;
  }
}
