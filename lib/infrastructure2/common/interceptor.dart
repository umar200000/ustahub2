import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ustahub/infrastructure/services/shared_perf/shared_pref_service.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';

import '../../application2/register_bloc_and_data/bloc/register_bloc.dart';
import 'dio_exception.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor();

  @override
  onPreRequest(RequestOptions options, RequestInterceptorHandler handler) {}

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final bool checkUnauthorized = !err.requestOptions.headers.containsKey(
      'check_token',
    );

    if (err.response?.statusCode == 401 && checkUnauthorized) {
      final prefService = sl<SharedPrefService>();
      final tokenModel = prefService.getTokenModel();

      if (tokenModel?.refreshToken != null) {
        try {
          // Tokenni yangilash uchun alohida Dio instance ishlatamiz (interceptor cheksiz aylanib qolmasligi uchun)
          final dio = Dio(BaseOptions(baseUrl: err.requestOptions.baseUrl));

          final response = await dio.post(
            "api/v1/auth/refresh/",
            data: {"refresh_token": tokenModel!.refreshToken},
          );

          if ((response.statusCode == 200 || response.statusCode == 201) &&
              response.data['success'] == true) {
            sl<RegisterBloc>().add(GetTokenEvent(data: response.data));
            final newData = response.data['data'];

            // Asl so'rovni yangi token bilan qayta yuboramiz
            final opts = err.requestOptions;
            opts.headers[HttpHeaders.authorizationHeader] =
                'Bearer ${newData["access_token"]}';

            final secondResponse = await dio.fetch(opts);
            return handler.resolve(secondResponse);
          }
        } catch (e) {
          debugPrint("Token refresh error: $e");
          // Refresh ham xato bersa, logout qilish yoki login sahifasiga yo'naltirish mumkin
          // prefService.clear();
        }
      }
    }

    return handler.next(
      DioExceptionX(
        requestOptions: err.requestOptions,
        statusCode: err.response?.statusCode,
        serverError: err.response?.data ?? {},
        errorType: err.type,
        checkUnauthorized: checkUnauthorized,
      ),
    );
  }
}
