import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';
import '../mock/category_list_mock_data.dart';

class CategoryListRepo {
  final _dio = sl<Dio>();

  Future<Response> getCategoriesList({
    required String id,
    int skip = 0,
    int limit = 20,
  }) async {
    // Use mock data
    if (CategoryListMockData.useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: CategoryListMockData.getMockServicesByCategory(
          id,
          skip: skip,
          limit: limit,
        ),
      );
    }

    final response = await _dio.get(
      "api/v1/client/services/",
      queryParameters: {"category_id": id, "skip": skip, "limit": limit},
    );
    return response;
  }
}
