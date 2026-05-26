import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class ClientExpressRepo {
  Dio get _dio => sl<Dio>();

  // GET /api/v1/client/regions/
  Future<Response> getRegions() {
    return _dio.get('api/v1/client/regions/');
  }

  // GET /api/v1/client/provinces/  (region_id ixtiyoriy)
  Future<Response> getProvinces({String? regionId}) {
    return _dio.get(
      'api/v1/client/provinces/',
      queryParameters:
          (regionId != null && regionId.isNotEmpty) ? {'region_id': regionId} : null,
    );
  }

  // GET /api/v1/client/districts/?province_id=...
  Future<Response> getDistricts({required String provinceId}) {
    return _dio.get(
      'api/v1/client/districts/',
      queryParameters: {'province_id': provinceId},
    );
  }

  // GET /api/v1/client/express/categories/?province_id=...
  Future<Response> getCategories({required String provinceId}) {
    return _dio.get(
      'api/v1/client/express/categories/',
      queryParameters: {'province_id': provinceId},
    );
  }

  // POST /api/v1/client/express/search/
  Future<Response> startSearch({
    required String categoryId,
    required String provinceId,
    String? districtId,
    required double latitude,
    required double longitude,
    required String paymentMethod,
  }) {
    final data = <String, dynamic>{
      'category_id': categoryId,
      'province_id': provinceId,
      'latitude': latitude,
      'longitude': longitude,
      'payment_method': paymentMethod,
    };
    if (districtId != null) data['district_id'] = districtId;

    return _dio.post('api/v1/client/express/search/', data: data);
  }

  // GET /api/v1/client/express/search/{session_id}/status/
  Future<Response> getStatus({required String sessionId}) {
    return _dio.get('api/v1/client/express/search/$sessionId/status/');
  }

  // POST /api/v1/client/express/search/{session_id}/cancel/
  Future<Response> cancelSearch({required String sessionId}) {
    return _dio.post('api/v1/client/express/search/$sessionId/cancel/');
  }
}
