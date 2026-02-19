import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';
import '../mock/category_mock_data.dart';

class CategoryRepo {
  final _dio = sl<Dio>();

  Future<Response> getCategories() async {
    // Use mock data
    if (CategoryMockData.useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: CategoryMockData.getMockCategories(),
      );
    }

    final response = await _dio.get("api/v1/client/services/categories/");
    return response;
  }
}
