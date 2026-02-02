import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/common/token.dart';
import 'package:ustahub/domain/common/token_ext.dart';
import 'package:ustahub/domain/failures/auth/auth_failure.dart';
import 'package:ustahub/domain/failures/auth/i_auth_facade.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';
import 'package:ustahub/infrastructure/apis/apis.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/utils/constants.dart';

class AuthRepository implements IAuthFacade {
  final DBService _dbService;
  final AuthService _authService;

  AuthRepository(this._dbService, this._authService);

  /// Get user
  @override
  Option<AuthFailure> checkUser() {
    final Token token = _dbService.token;
    return optionOf(token.hasFailure);
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>> registration({
    required RegisterReq request,
  }) async {
    try {
      final res = await _authService.registration(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>> verificationSend({
    required VerificationSendReq request,
  }) async {
    try {
      final res = await _authService.verificationSend(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, LoginRes>> verificationVerify({
    required VerificationVerifyReq request,
  }) async {
    try {
      final res = await _authService.verificationVerify(request: request);
      if (res.isSuccessful) {
        _dbService.setToken(
          Token(accessToken: res.body?.access, refreshToken: res.body?.refresh),
        );

        // Clear guest mode since user is now authenticated
        await _dbService.setGuestMode(false);

        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, LoginRes>> signIn({
    required SignInReq request,
  }) async {
    try {
      final res = await _authService.signIn(request: request);
      if (res.isSuccessful && res.body != null) {
        final loginRes = res.body!;
        if (loginRes.access != null && loginRes.refresh != null) {
          LogService.i("Sign in successful - saving tokens");
          await _dbService.setToken(
            Token(accessToken: loginRes.access, refreshToken: loginRes.refresh),
          );

          // Clear guest mode since user is now authenticated
          await _dbService.setGuestMode(false);

          return right(loginRes);
        } else {
          LogService.e("Sign in response missing tokens");
          return left(
            InvalidCredentials(message: 'invalid_token_response'.tr()),
          );
        }
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e("Sign in error: ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>> updatePassword({
    required ResetPasswordReq request,
  }) async {
    try {
      final res = await _authService.updatePassword(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, LoginRes>> forgotPassword({
    required ForgotPasswordReqModel request,
  }) async {
    try {
      final res = await _authService.forgotPassword(request: request);
      if (res.isSuccessful) {
        _dbService.setToken(
          Token(accessToken: res.body?.access, refreshToken: res.body?.refresh),
        );

        // Clear guest mode since user is now authenticated
        await _dbService.setGuestMode(false);

        // setFcmToken(res.body?.access ?? "");
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, SuccessModel>> updatePhone({
    required VerificationVerifyReq request,
  }) async {
    try {
      final res = await _authService.updatePhone(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteProfile() async {
    try {
      final res = await _authService.deleteProfile();

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProfileModel>> updateProfile({
    required ProfileModel request,
  }) async {
    try {
      final res = await _authService.updateProfile(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  static Future<Either<ResponseFailure, LoginRes>> refreshToken(
    String refresh,
  ) async {
    try {
      final response = await Dio().post(
        "${Constants.baseUrlP}user/token/refresh/",
        data: {'refresh': refresh},
        options: Options(
          headers: {'Accept-Language': 'app_lang'.tr(), 'Tenant': 'Sazu'},
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final String? newAccessToken = response.data['access'];

        if (newAccessToken == null) {
          LogService.e("Refresh token response missing access token");
          return left(
            InvalidCredentials(message: 'invalid_token_response'.tr()),
          );
        }

        return right(
          LoginRes(
            (b) => b
              ..refresh = refresh
              ..access = newAccessToken,
          ),
        );
      } else {
        LogService.e(
          "Refresh token failed with status: ${response.statusCode}",
        );
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } on DioException catch (e) {
      LogService.e("Refresh token DioError: ${e.message}");
      if (e.response?.statusCode == 401) {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
      return left(Unknown(message: 'network_error'.tr()));
    } catch (e) {
      LogService.e("Refresh token error: $e");
      return left(Unknown(message: 'unknown_error'.tr()));
    }
  }

  // Future<String> getDeviceModel() async {
  //   String? deviceId;
  //   try {
  //     deviceId = await PlatformDeviceId.getDeviceId;
  //   } catch (e) {
  //     LogService.e(e);
  //   }
  //   return deviceId ?? "";
  // }

  @override
  Future<Either<ResponseFailure, ProfileModel>> completeRegistration({
    required ProfileModel request,
  }) async {
    try {
      final res = await _authService.completeRegistration(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProfileModel>> getProfile() async {
    try {
      final res = await _authService.getProfile();

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, UserAddress>> addressAdd({
    required UserAddress request,
  }) async {
    try {
      final res = await _authService.addressAdd(request: request);

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, UserAddress>> addressUpdate({
    required int id,
    required UserAddress request,
  }) async {
    try {
      final res = await _authService.addressUpdate(id: id, request: request);

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, UserAddress>> addressRetrieve({
    required int id,
  }) async {
    try {
      final res = await _authService.addressRetrieve(id: id);

      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProductModel>> updateTopUp({
    required ProductModel request,
  }) async {
    try {
      final res = await _authService.updateTopUp(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProductModel>> updateAddressTopUp({
    required ProductModel request,
  }) async {
    try {
      final res = await _authService.updateAddressTopUp(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteAddress({
    required int id,
  }) async {
    try {
      final res = await _authService.deleteAddress(id: id);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, AppVersionModel>> getVersion() async {
    try {
      final res = await _authService.getVersion();
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, FCMTokenModel>> createFCMToken({
    required FCMTokenModel request,
  }) async {
    try {
      final res = await _authService.createFCMToken(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  // @override
  // Future<void> businessRegistration(
  //     {required String accessToken,
  //     required String refreshToken,
  //     required int id}) async {
  //   _dbService.setBool(key: DBService.business, isSaved: true);
  //   _dbService
  //       .setToken(Token(accessToken: accessToken, refreshToken: refreshToken));
  //   setFcmToken(accessToken);
  //   // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //   // firebaseMessaging.subscribeToTopic("business_user");
  //   // firebaseMessaging.subscribeToTopic("business_user_$id");
  //   AppsFlayer.instance.pushUserProfile("business_user_$id");
  // }
}
