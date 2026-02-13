import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class DetailsRepo {
  final _dio = sl<Dio>();

  Future<Response> getServiceDetails(String serviceId) async {
    final response = await _dio.get("api/v1/client/services/$serviceId/");
    return response;
  }
}
