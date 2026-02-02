import 'package:dartz/dartz.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';

import 'auth_failure.dart';

abstract class IAuthFacade {
  Option<AuthFailure> checkUser();

  Future<Either<ResponseFailure, SuccessModel>> registration({
    required RegisterReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> verificationSend({
    required VerificationSendReq request,
  });

  Future<Either<ResponseFailure, LoginRes>> verificationVerify({
    required VerificationVerifyReq request,
  });

  Future<Either<ResponseFailure, LoginRes>> signIn({
    required SignInReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> updatePassword({
    required ResetPasswordReq request,
  });

  Future<Either<ResponseFailure, ProfileModel>> updateProfile({
    required ProfileModel request,
  });

  Future<Either<ResponseFailure, SuccessModel>> updatePhone({
    required VerificationVerifyReq request,
  });

  Future<Either<ResponseFailure, dynamic>> deleteProfile();

  Future<Either<ResponseFailure, LoginRes>> forgotPassword({
    required ForgotPasswordReqModel request,
  });

  Future<Either<ResponseFailure, ProfileModel>> completeRegistration({
    required ProfileModel request,
  });

  Future<Either<ResponseFailure, ProfileModel>> getProfile();

  Future<Either<ResponseFailure, UserAddress>> addressAdd({
    required UserAddress request,
  });

  Future<Either<ResponseFailure, UserAddress>> addressUpdate({
    required int id,
    required UserAddress request,
  });

  Future<Either<ResponseFailure, UserAddress>> addressRetrieve({
    required int id,
  });

  Future<Either<ResponseFailure, ProductModel>> updateTopUp({
    required ProductModel request,
  });

  Future<Either<ResponseFailure, ProductModel>> updateAddressTopUp({
    required ProductModel request,
  });

  Future<Either<ResponseFailure, dynamic>> deleteAddress({required int id});

  Future<Either<ResponseFailure, AppVersionModel>> getVersion();

  Future<Either<ResponseFailure, FCMTokenModel>> createFCMToken({
    required FCMTokenModel request,
  });
}
