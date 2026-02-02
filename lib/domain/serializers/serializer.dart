import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/notification/notification_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';

part 'serializer.g.dart';

// Custom serializer to handle string-to-double conversion
class StringToDoubleSerializer implements PrimitiveSerializer<double> {
  @override
  double deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (serialized is num) {
      return serialized.toDouble();
    } else if (serialized is String) {
      try {
        return double.parse(serialized);
      } catch (_) {
        return 0.0;
      }
    }
    return 0.0;
  }

  @override
  Object serialize(
    Serializers serializers,
    double object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return object;
  }

  @override
  Iterable<Type> get types => [double];

  @override
  String get wireName => 'double';
}

@SerializersFor([
  //Auth
  RegisterReq,
  VerificationSendReq,
  VerificationVerifyReq,
  SignInReq,
  PasswordReq,
  LoginRes,
  SuccessModel,
  CheckAuthModel,
  ResetPasswordReq,
  ProfileModel,
  ForgotPasswordReqModel,
  UserAddress,
  PaymentChoicesModel,
  SupportModel,
  AppVersionModel,
  FCMTokenModel,

  //Main
  CurrencyModel,
  ImagesModel,
  MonitoringModel,
  MonitoringOrderModel,

  //Home
  BannerModel,
  SetModel,
  StoryModel,
  StoryItemModel,

  // Product
  SubCategoryModel,
  ItemModel,
  FamilyModel,
  ProductModel,
  Catalog,
  OrderModel,
  OrderReq,
  SearchModel,
  BrandData,
  Categories,
  SubCategories,
  FilterRes,
  FilterItemModel,
  OrderStatusRes,
  InformModel,
  PlannedOrderModel,
  Schedules,
  PlannedOrderListModel,
  InformRes,
  Inform,
  InformCreateRes,
  ProductCatalogResponse,
  ProductCategory,
  ModifiedModel,
  ProductDetailModel,
  NutritionModel,
  ProductModelResponse,
  DayModel,
  CategoryListModel,
  SectionModel,

  // Subscription
  CardModel,
  SubscriptionModel,
  SubscriptionReq,

  // Notification
  Notification,
  NotificationModel,
])
final Serializers serializers =
    (_$serializers.toBuilder()
          ..addPlugin(StandardJsonPlugin())
          ..add(StringToDoubleSerializer()))
        .build();
