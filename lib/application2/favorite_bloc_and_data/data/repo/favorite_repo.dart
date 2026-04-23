import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class FavoriteRepo {
  final _dio = sl<Dio>();

  Future<Response> getFavorites({int skip = 0, int limit = 20}) async {
    final response = await _dio.get(
      "api/v1/client/favorites/services/",
      queryParameters: {"skip": skip, "limit": limit},
    );
    return response;
  }

  Future<Response> addFavorite(String serviceId) async {
    final response = await _dio.post(
      "api/v1/client/favorites/services/$serviceId/",
    );
    return response;
  }

  Future<Response> removeFavorite(String serviceId) async {
    final response = await _dio.delete(
      "api/v1/client/favorites/services/$serviceId/",
    );
    return response;
  }
}
