import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ustahub/domain/abstract_repositories/profile/i_profile_facade.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';
import 'package:ustahub/infrastructure/apis/apis.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

class ProfileRepository implements IProfileFacade {
  final OrderService _service;
  final StoreService _storeService;
  final PaymentService _paymentService;
  final PremiumService _premiumService;

  ProfileRepository(
    this._service,
    this._storeService,
    this._paymentService,
    this._premiumService,
  );

  @override
  Future<Either<ResponseFailure, OrderModel>> getDraft() async {
    try {
      final res = await _service.getDraft();
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
  Future<Either<ResponseFailure, OrderModel>> postOrderCreate({
    required OrderReq request,
  }) async {
    try {
      final res = await _service.postOrderCreate(request: request);
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
  Future<Either<ResponseFailure, CurrencyModel>> promocodeValidate({
    required OrderReq request,
  }) async {
    try {
      final res = await _storeService.promocodeValidate(request: request);
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
  Future<Either<ResponseFailure, SuccessModel>> putOrder({
    required OrderReq request,
    required int id,
  }) async {
    try {
      final res = await _service.putOrder(request: request, id: id);
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
  Future<Either<ResponseFailure, OrderStatusRes>> status({
    required int id,
  }) async {
    try {
      final res = await _service.status(id: id);
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
  Future<Either<ResponseFailure, List<OrderModel>>> getHistory() async {
    try {
      final res = await _service.getHistory();
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
  Future<Either<ResponseFailure, List<OrderModel>>> getActiveList() async {
    try {
      final res = await _service.getActiveList();
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
  Future<Either<ResponseFailure, List<ModifiedModel>>>
  getDraftCheckAvailability() async {
    try {
      final res = await _service.getDraftCheckAvailability();
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
  Future<Either<ResponseFailure, OrderModel>> getOrderItem({
    required int id,
  }) async {
    try {
      final res = await _service.getOrderItem(id: id);
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
  Future<Either<ResponseFailure, CardModel>> createCard({
    required CardModel request,
  }) async {
    try {
      final res = await _paymentService.createCard(request: request);
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
  Future<Either<ResponseFailure, CardModel>> verifyCard({
    required CardModel request,
  }) async {
    try {
      final res = await _paymentService.verifyCard(request: request);
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
  Future<Either<ResponseFailure, SubscriptionReq>> postSubscriptionCreate({
    required SubscriptionReq request,
  }) async {
    try {
      final res = await _premiumService.postSubscriptionCreate(
        request: request,
      );
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
  Future<Either<ResponseFailure, SuccessModel>> getPlannedSoon() async {
    try {
      final res = await _service.getPlannedSoon();
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
  Future<Either<ResponseFailure, dynamic>> deleteCard({required int id}) async {
    try {
      final res = await _paymentService.deleteCard(id: id);
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
  Future<Either<ResponseFailure, OrderModel>> postRepeat({
    required OrderModel request,
  }) async {
    try {
      final res = await _service.postRepeat(request: request);
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
  Future<Either<ResponseFailure, PlannedOrderModel>> createPlannedOrder({
    required PlannedOrderModel request,
  }) async {
    try {
      final res = await _service.createPlannedOrder(request: request);
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
  Future<Either<ResponseFailure, PlannedOrderModel>> updatePlannedOrder({
    required PlannedOrderModel request,
    required int id,
  }) async {
    try {
      final res = await _service.updatePlannedOrder(request: request, id: id);
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
  Future<Either<ResponseFailure, PlannedOrderModel>> addToPlannedOrder({
    required PlannedOrderModel request,
    required int id,
  }) async {
    try {
      final res = await _service.addToPlannedOrder(request: request, id: id);
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
  Future<Either<ResponseFailure, List<PlannedOrderModel>>>
  getPlannedOrderList() async {
    try {
      final res = await _service.getPlannedOrderList();
      if (res.isSuccessful) {
        return right(res.body!.results!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, PlannedOrderModel>> getPlannedOrderDetail({
    required int id,
  }) async {
    try {
      final res = await _service.getPlannedOrderDetail(id: id);
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
  Future<Either<ResponseFailure, MonitoringModel>> getMonitoring({
    required String dateFrom,
    required String dateTo,
  }) async {
    try {
      final res = await _service.getMonitoring(
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
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
  Future<Either<ResponseFailure, ProductModelResponse>> getTopItems({
    int? page,
  }) async {
    try {
      final res = page != null
          ? await _service.getTopItems(page: page)
          : await _service.getTopItems();

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
  Future<Either<ResponseFailure, List<ProductModel>>>
  getRecommendation() async {
    try {
      final res = await _storeService.getRecommendation();

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
  Future<Either<ResponseFailure, PlannedOrderModel>> updatePlannedOrderStatus({
    required PlannedOrderModel request,
    required int id,
  }) async {
    try {
      final res = await _service.updatePlannedOrderStatus(
        request: request,
        id: id,
      );
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
  Future<Either<ResponseFailure, dynamic>> deletePlannedOrder({
    required int id,
  }) async {
    try {
      final res = await _service.deletePlannedOrder(id: id);
      if (res.isSuccessful) {
        return right(res.body);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<ProductModel>>> getDeliveryPrice({
    int? addressId,
  }) async {
    try {
      final res = await _service.getDeliveryPrice(addressId: addressId);
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
  Future<Either<ResponseFailure, List<SectionModel>>> getSectionList() async {
    try {
      final res = await _storeService.getSectionList();
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
  Future<Either<ResponseFailure, SectionModel>> getSectionById({
    required int id,
  }) async {
    try {
      final res = await _storeService.getSectionById(id: id);
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
}
