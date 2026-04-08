import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class CategoryRepo {
  final _dio = sl<Dio>();

  Future<Response> getCategories() async {
    final response = await _dio.get("api/v1/client/services/categories/");
    return response;
  }
}
