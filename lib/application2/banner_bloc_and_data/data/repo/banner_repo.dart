import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class BannerRepo {
  final _dio = sl<Dio>();

  Future<Response> getBanners() async {
    final response = await _dio.get("/api/v1/banners/active");
    return response;
  }

  Future<Response> getBannerDetails({required String id}) async {
    final response = await _dio.get("api/v1/banners/$id/");
    return response;
  }
}
