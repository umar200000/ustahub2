import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ustahub/domain/models/product/product_model.dart';

part 'auth.g.dart';

/// verification send
abstract class VerificationSendReq
    implements Built<VerificationSendReq, VerificationSendReqBuilder> {
  VerificationSendReq._();

  factory VerificationSendReq([
    Function(VerificationSendReqBuilder b) updates,
  ]) = _$VerificationSendReq;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  // @BuiltValueField(wireName: 'autofill')
  // String? get autofill;

  static Serializer<VerificationSendReq> get serializer =>
      _$verificationSendReqSerializer;
}

/// verification verify
abstract class VerificationVerifyReq
    implements Built<VerificationVerifyReq, VerificationVerifyReqBuilder> {
  VerificationVerifyReq._();

  factory VerificationVerifyReq([
    Function(VerificationVerifyReqBuilder b) updates,
  ]) = _$VerificationVerifyReq;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  @BuiltValueField(wireName: 'code')
  String? get code;

  static Serializer<VerificationVerifyReq> get serializer =>
      _$verificationVerifyReqSerializer;
}

///registeration
abstract class RegisterReq implements Built<RegisterReq, RegisterReqBuilder> {
  RegisterReq._();

  factory RegisterReq([Function(RegisterReqBuilder b) updates]) = _$RegisterReq;

  @BuiltValueField(wireName: 'full_name')
  String? get fullName;

  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<RegisterReq> get serializer => _$registerReqSerializer;
}

/// login

abstract class SignInReq implements Built<SignInReq, SignInReqBuilder> {
  SignInReq._();

  factory SignInReq([Function(SignInReqBuilder b) updates]) = _$SignInReq;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<SignInReq> get serializer => _$signInReqSerializer;
}

abstract class LoginRes implements Built<LoginRes, LoginResBuilder> {
  LoginRes._();

  factory LoginRes([Function(LoginResBuilder b) updates]) = _$LoginRes;

  @BuiltValueField(wireName: 'access')
  String? get access;

  @BuiltValueField(wireName: 'refresh')
  String? get refresh;

  @BuiltValueField(wireName: 'message')
  String? get message;

  @BuiltValueField(wireName: 'is_user')
  bool? get isUser;

  static Serializer<LoginRes> get serializer => _$loginResSerializer;
}

/// update password

abstract class PasswordReq implements Built<PasswordReq, PasswordReqBuilder> {
  PasswordReq._();

  factory PasswordReq([Function(PasswordReqBuilder b) updates]) = _$PasswordReq;

  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<PasswordReq> get serializer => _$passwordReqSerializer;
}

abstract class CheckAuthModel
    implements Built<CheckAuthModel, CheckAuthModelBuilder> {
  CheckAuthModel._();

  factory CheckAuthModel([Function(CheckAuthModelBuilder b) updates]) =
      _$CheckAuthModel;

  @BuiltValueField(wireName: 'type')
  String? get type;
  @BuiltValueField(wireName: 'detail')
  String? get detail;

  static Serializer<CheckAuthModel> get serializer =>
      _$checkAuthModelSerializer;
}

/// reset password
abstract class ResetPasswordReq
    implements Built<ResetPasswordReq, ResetPasswordReqBuilder> {
  ResetPasswordReq._();

  factory ResetPasswordReq([Function(ResetPasswordReqBuilder b) updates]) =
      _$ResetPasswordReq;

  @BuiltValueField(wireName: 'old-pwd')
  String? get oldPwd;
  @BuiltValueField(wireName: 'new-pwd')
  String? get newPwd;

  static Serializer<ResetPasswordReq> get serializer =>
      _$resetPasswordReqSerializer;
}

abstract class ForgotPasswordReqModel
    implements Built<ForgotPasswordReqModel, ForgotPasswordReqModelBuilder> {
  ForgotPasswordReqModel._();

  factory ForgotPasswordReqModel([
    Function(ForgotPasswordReqModelBuilder b) updates,
  ]) = _$ForgotPasswordReqModel;

  @BuiltValueField(wireName: 'code')
  String? get code;
  @BuiltValueField(wireName: 'phone_number')
  String? get phone;
  @BuiltValueField(wireName: 'password')
  String? get password;

  static Serializer<ForgotPasswordReqModel> get serializer =>
      _$forgotPasswordReqModelSerializer;
}

abstract class UserAddress implements Built<UserAddress, UserAddressBuilder> {
  UserAddress._();

  factory UserAddress([Function(UserAddressBuilder b) updates]) = _$UserAddress;

  @BuiltValueField(wireName: 'address')
  String? get address;

  @BuiltValueField(wireName: 'address_name')
  String? get addressName;

  @BuiltValueField(wireName: 'longitude')
  double? get longitude;

  @BuiltValueField(wireName: 'latitude')
  double? get latitude;

  @BuiltValueField(wireName: 'user')
  int? get user;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'nearest_warehouse')
  int? get nearestWarehouse;

  @BuiltValueField(wireName: 'home')
  String? get home;

  @BuiltValueField(wireName: 'entrance')
  String? get entrance;

  @BuiltValueField(wireName: 'floor')
  String? get floor;

  @BuiltValueField(wireName: 'apartment')
  String? get apartment;

  @BuiltValueField(wireName: 'comment')
  String? get comment;

  @BuiltValueField(wireName: 'address_type')
  int? get addressType;

  @BuiltValueField(wireName: 'estimated_arrival_time')
  int? get estimatedArrivalTime;

  @BuiltValueField(wireName: 'disable')
  bool? get disable;

  @BuiltValueField(wireName: 'entrance_key')
  String? get entranceKey;

  static Serializer<UserAddress> get serializer => _$userAddressSerializer;
}

abstract class ProfileModel
    implements Built<ProfileModel, ProfileModelBuilder> {
  ProfileModel._();

  factory ProfileModel([Function(ProfileModelBuilder b) updates]) =
      _$ProfileModel;

  @BuiltValueField(wireName: 'full_name')
  String? get fullName;
  @BuiltValueField(wireName: 'gender')
  String? get gender;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'payment')
  String? get payment;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;
  @BuiltValueField(wireName: 'date_birth')
  String? get dateBirth;
  @BuiltValueField(wireName: 'sort_product')
  int? get sortProduct;
  @BuiltValueField(wireName: 'monthly_spend')
  double? get monthlySpend;
  @BuiltValueField(wireName: 'adult')
  int? get adult;
  @BuiltValueField(wireName: 'child')
  int? get child;
  @BuiltValueField(wireName: 'chat')
  bool? get chat;
  @BuiltValueField(wireName: 'phone')
  bool? get phone;
  @BuiltValueField(wireName: 'is_premium')
  bool? get isPremium;
  @BuiltValueField(wireName: 'telegram')
  bool? get telegram;
  @BuiltValueField(wireName: 'instagram')
  bool? get instagram;
  @BuiltValueField(wireName: 'order_editable')
  bool? get orderEditable;
  @BuiltValueField(wireName: 'user_address')
  BuiltList<UserAddress>? get userAddress;
  @BuiltValueField(wireName: 'address')
  BuiltList<UserAddress>? get address;
  @BuiltValueField(wireName: 'payment_choices')
  BuiltList<PaymentChoicesModel>? get paymentChoices;
  @BuiltValueField(wireName: 'balance')
  double? get balance;
  @BuiltValueField(wireName: 'service')
  OrderReq? get service;
  @BuiltValueField(wireName: 'support')
  SupportModel? get support;
  @BuiltValueField(wireName: 'lang')
  String? get lang;
  @BuiltValueField(wireName: 'planned_orders')
  BuiltList<PlannedOrderModel>? get plannedOrders;
  @BuiltValueField(wireName: 'subscription_plan')
  SubscriptionModel? get subscriptionPlan;
  @BuiltValueField(wireName: 'is_subscribed')
  bool? get isSubscribed;
  @BuiltValueField(wireName: 'subscription_end')
  String? get subscriptionEnd;

  static Serializer<ProfileModel> get serializer => _$profileModelSerializer;
}

abstract class SupportModel
    implements Built<SupportModel, SupportModelBuilder> {
  SupportModel._();

  factory SupportModel([Function(SupportModelBuilder b) updates]) =
      _$SupportModel;

  @BuiltValueField(wireName: 'call_center')
  String? get callCenter;
  @BuiltValueField(wireName: 'telegram_bot')
  String? get telegramBot;

  static Serializer<SupportModel> get serializer => _$supportModelSerializer;
}

abstract class PaymentChoicesModel
    implements Built<PaymentChoicesModel, PaymentChoicesModelBuilder> {
  PaymentChoicesModel._();

  factory PaymentChoicesModel([
    Function(PaymentChoicesModelBuilder b) updates,
  ]) = _$PaymentChoicesModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'card_id')
  String? get cardId;

  @BuiltValueField(wireName: 'card')
  String? get card;

  @BuiltValueField(wireName: 'type')
  String? get type;

  @BuiltValueField(wireName: 'balance')
  double? get balance;

  static Serializer<PaymentChoicesModel> get serializer =>
      _$paymentChoicesModelSerializer;
}

abstract class CardModel implements Built<CardModel, CardModelBuilder> {
  CardModel._();

  factory CardModel([Function(CardModelBuilder b) updates]) = _$CardModel;

  @BuiltValueField(wireName: 'card_number')
  String? get cardNumber;
  @BuiltValueField(wireName: 'expire_date')
  String? get expireDate;
  @BuiltValueField(wireName: 'cvv')
  String? get cvv;
  @BuiltValueField(wireName: 'otp_code')
  String? get otpCode;

  static Serializer<CardModel> get serializer => _$cardModelSerializer;
}

abstract class SubscriptionModel
    implements Built<SubscriptionModel, SubscriptionModelBuilder> {
  SubscriptionModel._();

  factory SubscriptionModel([Function(SubscriptionModelBuilder b) updates]) =
      _$SubscriptionModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'price')
  double? get price;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'duration_days')
  int? get durationDays;

  static Serializer<SubscriptionModel> get serializer =>
      _$subscriptionModelSerializer;
}

abstract class SubscriptionReq
    implements Built<SubscriptionReq, SubscriptionReqBuilder> {
  SubscriptionReq._();

  factory SubscriptionReq([Function(SubscriptionReqBuilder b) updates]) =
      _$SubscriptionReq;

  @BuiltValueField(wireName: 'subscription')
  int? get subscription;
  @BuiltValueField(wireName: 'user')
  int? get user;
  @BuiltValueField(wireName: 'card_id')
  int? get cardId;
  @BuiltValueField(wireName: 'payment_id')
  int? get paymentId;

  static Serializer<SubscriptionReq> get serializer =>
      _$subscriptionReqSerializer;
}

abstract class AppVersionModel
    implements Built<AppVersionModel, AppVersionModelBuilder> {
  AppVersionModel._();

  factory AppVersionModel([Function(AppVersionModelBuilder b) updates]) =
      _$AppVersionModel;

  @BuiltValueField(wireName: 'android')
  String? get android;
  @BuiltValueField(wireName: 'ios')
  String? get ios;

  static Serializer<AppVersionModel> get serializer =>
      _$appVersionModelSerializer;
}

abstract class FCMTokenModel
    implements Built<FCMTokenModel, FCMTokenModelBuilder> {
  FCMTokenModel._();

  factory FCMTokenModel([Function(FCMTokenModelBuilder b) updates]) =
      _$FCMTokenModel;

  @BuiltValueField(wireName: 'firebase_token')
  String? get firebaseToken;
  @BuiltValueField(wireName: 'platform')
  String? get platform;
  @BuiltValueField(wireName: 'last_version')
  String? get lastVersion;
  @BuiltValueField(wireName: 'is_category_grid')
  bool? get isCategoryGrid;
  @BuiltValueField(wireName: 'is_product_grid')
  bool? get isProductGrid;

  static Serializer<FCMTokenModel> get serializer => _$fCMTokenModelSerializer;
}
