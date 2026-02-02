import 'package:dartz/dartz.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';

abstract class IProfileFacade {
  Future<Either<ResponseFailure, OrderModel>> getDraft();

  Future<Either<ResponseFailure, MonitoringModel>> getMonitoring({
    required String dateFrom,
    required String dateTo,
  });

  Future<Either<ResponseFailure, ProductModelResponse>> getTopItems({
    int? page,
  });

  Future<Either<ResponseFailure, List<ProductModel>>> getRecommendation();

  Future<Either<ResponseFailure, OrderModel>> postOrderCreate({
    required OrderReq request,
  });

  Future<Either<ResponseFailure, CurrencyModel>> promocodeValidate({
    required OrderReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> putOrder({
    required OrderReq request,
    required int id,
  });

  Future<Either<ResponseFailure, OrderStatusRes>> status({required int id});

  Future<Either<ResponseFailure, List<OrderModel>>> getHistory();

  Future<Either<ResponseFailure, List<OrderModel>>> getActiveList();

  Future<Either<ResponseFailure, OrderModel>> getOrderItem({required int id});

  Future<Either<ResponseFailure, CardModel>> createCard({
    required CardModel request,
  });

  Future<Either<ResponseFailure, CardModel>> verifyCard({
    required CardModel request,
  });

  Future<Either<ResponseFailure, SubscriptionReq>> postSubscriptionCreate({
    required SubscriptionReq request,
  });

  Future<Either<ResponseFailure, SuccessModel>> getPlannedSoon();

  Future<Either<ResponseFailure, dynamic>> deleteCard({required int id});

  Future<Either<ResponseFailure, List<ModifiedModel>>>
  getDraftCheckAvailability();

  Future<Either<ResponseFailure, OrderModel>> postRepeat({
    required OrderModel request,
  });

  Future<Either<ResponseFailure, PlannedOrderModel>> createPlannedOrder({
    required PlannedOrderModel request,
  });

  Future<Either<ResponseFailure, PlannedOrderModel>> updatePlannedOrder({
    required PlannedOrderModel request,
    required int id,
  });

  Future<Either<ResponseFailure, PlannedOrderModel>> addToPlannedOrder({
    required PlannedOrderModel request,
    required int id,
  });

  Future<Either<ResponseFailure, List<PlannedOrderModel>>>
  getPlannedOrderList();

  Future<Either<ResponseFailure, PlannedOrderModel>> getPlannedOrderDetail({
    required int id,
  });

  Future<Either<ResponseFailure, PlannedOrderModel>> updatePlannedOrderStatus({
    required PlannedOrderModel request,
    required int id,
  });

  Future<Either<ResponseFailure, dynamic>> deletePlannedOrder({
    required int id,
  });

  Future<Either<ResponseFailure, List<ProductModel>>> getDeliveryPrice({
    int? addressId,
  });

  Future<Either<ResponseFailure, List<SectionModel>>> getSectionList();

  Future<Either<ResponseFailure, SectionModel>> getSectionById({
    required int id,
  });
}
