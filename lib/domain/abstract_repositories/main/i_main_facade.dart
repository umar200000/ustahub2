import 'package:dartz/dartz.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/notification/notification_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';

abstract class IMainFacade {
  Future<Either<ResponseFailure, CurrencyModel>> getCurrency();

  Future<Either<ResponseFailure, List<BannerModel>>> getBannerList();

  Future<Either<ResponseFailure, List<SetModel>>> getSetPackage();

  Future<Either<ResponseFailure, List<StoryModel>>> getStoryList();

  Future<Either<ResponseFailure, List<FilterRes>>> getCountry({
    int? categoryId,
  });

  Future<Either<ResponseFailure, List<FilterRes>>> getBrandShort({
    required String? countryId,
    int? categoryId,
  });

  Future<Either<ResponseFailure, Notification>> getNotificationList();

  Future<Either<ResponseFailure, dynamic>> updateNotification({
    required int id,
    required NotificationModel body,
  });

  Future<Either<ResponseFailure, Inform>> getInformList();

  Future<Either<ResponseFailure, List<FamilyModel>>> getTenantSetPackage();

  Future<Either<ResponseFailure, List<ProductCategory>>> getTenantCategory();
}
