// ignore_for_file: unused_field

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ustahub/domain/abstract_repositories/main/i_main_facade.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/notification/notification_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/infrastructure/apis/apis.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

class MainRepository implements IMainFacade {
  final MainService _service;
  final AssetService _assetService;
  final StoreService _storeService;

  MainRepository(this._service, this._assetService, this._storeService);

  @override
  Future<Either<ResponseFailure, CurrencyModel>> getCurrency() async {
    try {
      final res = await _service.getCurrency();
      if (res.isSuccessful) {
        DBService dbService = await DBService.create;
        dbService.setCurrencyAmount(res.body!);
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
  Future<Either<ResponseFailure, List<BannerModel>>> getBannerList() async {
    try {
      final res = await _assetService.getBannerList();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<SetModel>>> getSetPackage() async {
    try {
      final res = await _storeService.getSetPackage();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<StoryModel>>> getStoryList() async {
    try {
      final res = await _assetService.getStoryList();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<FilterRes>>> getBrandShort({
    required String? countryId,
    int? categoryId,
  }) async {
    try {
      final res = await _storeService.getBrandShort(
        countryId: countryId,
        categoryId: categoryId,
      );
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<FilterRes>>> getCountry({
    int? categoryId,
  }) async {
    try {
      final res = await _storeService.getCountry(categoryId: categoryId);
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, Notification>> getNotificationList() async {
    try {
      final res = await _assetService.getNotificationList();
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
  Future<Either<ResponseFailure, dynamic>> updateNotification({
    required int id,
    required NotificationModel body,
  }) async {
    try {
      final res = await _assetService.updateNotification(id: id, body: body);
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
  Future<Either<ResponseFailure, Inform>> getInformList() async {
    try {
      final res = await _assetService.getInformList();
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
  Future<Either<ResponseFailure, List<FamilyModel>>>
  getTenantSetPackage() async {
    try {
      final res = await _storeService.getTenantSetPackage();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<ProductCategory>>>
  getTenantCategory() async {
    try {
      final res = await _storeService.getTenantCategory();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }
}
