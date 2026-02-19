import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';
import '../mock/banner_mock_data.dart';

class BannerRepo {
  final _dio = sl<Dio>();

  Future<Response> getBanners() async {
    // Use mock data
    if (BannerMockData.useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: BannerMockData.getMockBanners(),
      );
    }

    final response = await _dio.get("/api/v1/banners/active");
    return response;
  }

  Future<Response> getBannerDetails({required String id}) async {
    // Use mock data
    if (BannerMockData.useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: BannerMockData.getMockBannerDetails(id),
      );
    }

    final response = await _dio.get("api/v1/banners/$id/");
    return response;
  }
}
