import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class CompanyRepo {
  final _dio = sl<Dio>();

  Future<Response> getProviders() async {
    final response = await _dio.get("api/v1/client/providers/");
    return response;
  }

  Future<Response> getProviderDetails(String providerId) async {
    final response = await _dio.get("api/v1/client/providers/$providerId/");
    return response;
  }

  Future<Response> getProviderServices(
    String providerId, {
    int skip = 0,
    int limit = 20,
  }) async {
    final response = await _dio.get(
      "api/v1/client/services/provider/$providerId/",
      queryParameters: {"skip": skip, "limit": limit},
    );
    return response;
  }
}
