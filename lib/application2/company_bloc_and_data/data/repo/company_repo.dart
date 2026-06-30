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
    String? masterId,
    int skip = 0,
    int limit = 20,
  }) async {
    final params = <String, dynamic>{"skip": skip, "limit": limit};
    if (masterId != null) params["master_id"] = masterId;
    final response = await _dio.get(
      "api/v1/client/services/provider/$providerId/",
      queryParameters: params,
    );
    return response;
  }
}
