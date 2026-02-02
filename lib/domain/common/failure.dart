import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ustahub/infrastructure/core/exceptions.dart';

part 'failure.freezed.dart';

@freezed
abstract class ResponseFailure with _$ResponseFailure {
  const factory ResponseFailure.invalidCredential({required String message}) =
      InvalidCredentials;

  const factory ResponseFailure.noAdminAccess({required String message}) =
      NoAdminAccess;

  const factory ResponseFailure.networkFailure({required String message}) =
      NetworkFailure;

  const factory ResponseFailure.unknown({required String message}) = Unknown;
}

ResponseFailure handleError(dynamic e) {
  if (e is NetworkException) {
    return NetworkFailure(message: e.message);
  } else if (e is BackendExceptionForSentry) {
    try {
      Map<String, dynamic> res = jsonDecode(utf8.decode(e.response.bodyBytes));
      if (res.containsKey('detail')) {
        return Unknown(message: res['detail']);
      } else if (res.containsKey('error')) {
        return Unknown(message: res['error']);
      } else {
        return Unknown(
          message:
              e.response.body?.toString().replaceAll("\n", " ") ??
              'unknown_error'.tr(),
        );
      }
    } catch (error) {
      return Unknown(message: e.response.body ?? 'unknown_error'.tr());
    }
  } else if (e is TimeoutException) {
    return NetworkFailure(message: "low_connection_internet".tr());
  } else if (e is BackendException) {
    return NetworkFailure(message: e.message);
  } else {
    return Unknown(message: 'unknown_error'.tr());
  }
}
