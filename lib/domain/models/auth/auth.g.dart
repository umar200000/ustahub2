// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<VerificationSendReq> _$verificationSendReqSerializer =
    new _$VerificationSendReqSerializer();
Serializer<VerificationVerifyReq> _$verificationVerifyReqSerializer =
    new _$VerificationVerifyReqSerializer();
Serializer<RegisterReq> _$registerReqSerializer = new _$RegisterReqSerializer();
Serializer<SignInReq> _$signInReqSerializer = new _$SignInReqSerializer();
Serializer<LoginRes> _$loginResSerializer = new _$LoginResSerializer();
Serializer<PasswordReq> _$passwordReqSerializer = new _$PasswordReqSerializer();
Serializer<CheckAuthModel> _$checkAuthModelSerializer =
    new _$CheckAuthModelSerializer();
Serializer<ResetPasswordReq> _$resetPasswordReqSerializer =
    new _$ResetPasswordReqSerializer();
Serializer<ForgotPasswordReqModel> _$forgotPasswordReqModelSerializer =
    new _$ForgotPasswordReqModelSerializer();
Serializer<UserAddress> _$userAddressSerializer = new _$UserAddressSerializer();
Serializer<ProfileModel> _$profileModelSerializer =
    new _$ProfileModelSerializer();
Serializer<SupportModel> _$supportModelSerializer =
    new _$SupportModelSerializer();
Serializer<PaymentChoicesModel> _$paymentChoicesModelSerializer =
    new _$PaymentChoicesModelSerializer();
Serializer<CardModel> _$cardModelSerializer = new _$CardModelSerializer();
Serializer<SubscriptionModel> _$subscriptionModelSerializer =
    new _$SubscriptionModelSerializer();
Serializer<SubscriptionReq> _$subscriptionReqSerializer =
    new _$SubscriptionReqSerializer();
Serializer<AppVersionModel> _$appVersionModelSerializer =
    new _$AppVersionModelSerializer();
Serializer<FCMTokenModel> _$fCMTokenModelSerializer =
    new _$FCMTokenModelSerializer();

class _$VerificationSendReqSerializer
    implements StructuredSerializer<VerificationSendReq> {
  @override
  final Iterable<Type> types = const [
    VerificationSendReq,
    _$VerificationSendReq,
  ];
  @override
  final String wireName = 'VerificationSendReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    VerificationSendReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  VerificationSendReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new VerificationSendReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'phone_number':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$VerificationVerifyReqSerializer
    implements StructuredSerializer<VerificationVerifyReq> {
  @override
  final Iterable<Type> types = const [
    VerificationVerifyReq,
    _$VerificationVerifyReq,
  ];
  @override
  final String wireName = 'VerificationVerifyReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    VerificationVerifyReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  VerificationVerifyReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new VerificationVerifyReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'phone_number':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'code':
          result.code =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$RegisterReqSerializer implements StructuredSerializer<RegisterReq> {
  @override
  final Iterable<Type> types = const [RegisterReq, _$RegisterReq];
  @override
  final String wireName = 'RegisterReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    RegisterReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.fullName;
    if (value != null) {
      result
        ..add('full_name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  RegisterReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new RegisterReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'full_name':
          result.fullName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'password':
          result.password =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SignInReqSerializer implements StructuredSerializer<SignInReq> {
  @override
  final Iterable<Type> types = const [SignInReq, _$SignInReq];
  @override
  final String wireName = 'SignInReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SignInReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  SignInReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SignInReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'phone_number':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'password':
          result.password =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResSerializer implements StructuredSerializer<LoginRes> {
  @override
  final Iterable<Type> types = const [LoginRes, _$LoginRes];
  @override
  final String wireName = 'LoginRes';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    LoginRes object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.access;
    if (value != null) {
      result
        ..add('access')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.refresh;
    if (value != null) {
      result
        ..add('refresh')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isUser;
    if (value != null) {
      result
        ..add('is_user')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    return result;
  }

  @override
  LoginRes deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new LoginResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'access':
          result.access =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'refresh':
          result.refresh =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'is_user':
          result.isUser =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$PasswordReqSerializer implements StructuredSerializer<PasswordReq> {
  @override
  final Iterable<Type> types = const [PasswordReq, _$PasswordReq];
  @override
  final String wireName = 'PasswordReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    PasswordReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  PasswordReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new PasswordReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'password':
          result.password =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$CheckAuthModelSerializer
    implements StructuredSerializer<CheckAuthModel> {
  @override
  final Iterable<Type> types = const [CheckAuthModel, _$CheckAuthModel];
  @override
  final String wireName = 'CheckAuthModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CheckAuthModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.detail;
    if (value != null) {
      result
        ..add('detail')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  CheckAuthModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new CheckAuthModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'detail':
          result.detail =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ResetPasswordReqSerializer
    implements StructuredSerializer<ResetPasswordReq> {
  @override
  final Iterable<Type> types = const [ResetPasswordReq, _$ResetPasswordReq];
  @override
  final String wireName = 'ResetPasswordReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ResetPasswordReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.oldPwd;
    if (value != null) {
      result
        ..add('old-pwd')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.newPwd;
    if (value != null) {
      result
        ..add('new-pwd')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  ResetPasswordReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ResetPasswordReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'old-pwd':
          result.oldPwd =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'new-pwd':
          result.newPwd =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ForgotPasswordReqModelSerializer
    implements StructuredSerializer<ForgotPasswordReqModel> {
  @override
  final Iterable<Type> types = const [
    ForgotPasswordReqModel,
    _$ForgotPasswordReqModel,
  ];
  @override
  final String wireName = 'ForgotPasswordReqModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ForgotPasswordReqModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  ForgotPasswordReqModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ForgotPasswordReqModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'code':
          result.code =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'phone_number':
          result.phone =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'password':
          result.password =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UserAddressSerializer implements StructuredSerializer<UserAddress> {
  @override
  final Iterable<Type> types = const [UserAddress, _$UserAddress];
  @override
  final String wireName = 'UserAddress';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    UserAddress object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.addressName;
    if (value != null) {
      result
        ..add('address_name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.longitude;
    if (value != null) {
      result
        ..add('longitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.latitude;
    if (value != null) {
      result
        ..add('latitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.nearestWarehouse;
    if (value != null) {
      result
        ..add('nearest_warehouse')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.home;
    if (value != null) {
      result
        ..add('home')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.entrance;
    if (value != null) {
      result
        ..add('entrance')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.floor;
    if (value != null) {
      result
        ..add('floor')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.apartment;
    if (value != null) {
      result
        ..add('apartment')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.addressType;
    if (value != null) {
      result
        ..add('address_type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.estimatedArrivalTime;
    if (value != null) {
      result
        ..add('estimated_arrival_time')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.disable;
    if (value != null) {
      result
        ..add('disable')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.entranceKey;
    if (value != null) {
      result
        ..add('entrance_key')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  UserAddress deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new UserAddressBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'address':
          result.address =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'address_name':
          result.addressName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'longitude':
          result.longitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'latitude':
          result.latitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'user':
          result.user =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'id':
          result.id =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'nearest_warehouse':
          result.nearestWarehouse =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'home':
          result.home =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'entrance':
          result.entrance =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'floor':
          result.floor =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'apartment':
          result.apartment =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'comment':
          result.comment =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'address_type':
          result.addressType =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'estimated_arrival_time':
          result.estimatedArrivalTime =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'disable':
          result.disable =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'entrance_key':
          result.entranceKey =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfileModelSerializer implements StructuredSerializer<ProfileModel> {
  @override
  final Iterable<Type> types = const [ProfileModel, _$ProfileModel];
  @override
  final String wireName = 'ProfileModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ProfileModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.fullName;
    if (value != null) {
      result
        ..add('full_name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.gender;
    if (value != null) {
      result
        ..add('gender')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.payment;
    if (value != null) {
      result
        ..add('payment')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.dateBirth;
    if (value != null) {
      result
        ..add('date_birth')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.sortProduct;
    if (value != null) {
      result
        ..add('sort_product')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.monthlySpend;
    if (value != null) {
      result
        ..add('monthly_spend')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.adult;
    if (value != null) {
      result
        ..add('adult')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.child;
    if (value != null) {
      result
        ..add('child')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.chat;
    if (value != null) {
      result
        ..add('chat')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.isPremium;
    if (value != null) {
      result
        ..add('is_premium')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.telegram;
    if (value != null) {
      result
        ..add('telegram')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.instagram;
    if (value != null) {
      result
        ..add('instagram')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.orderEditable;
    if (value != null) {
      result
        ..add('order_editable')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.userAddress;
    if (value != null) {
      result
        ..add('user_address')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(UserAddress),
            ]),
          ),
        );
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(UserAddress),
            ]),
          ),
        );
    }
    value = object.paymentChoices;
    if (value != null) {
      result
        ..add('payment_choices')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(PaymentChoicesModel),
            ]),
          ),
        );
    }
    value = object.balance;
    if (value != null) {
      result
        ..add('balance')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.service;
    if (value != null) {
      result
        ..add('service')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(OrderReq)),
        );
    }
    value = object.support;
    if (value != null) {
      result
        ..add('support')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(SupportModel),
          ),
        );
    }
    value = object.lang;
    if (value != null) {
      result
        ..add('lang')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.plannedOrders;
    if (value != null) {
      result
        ..add('planned_orders')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(PlannedOrderModel),
            ]),
          ),
        );
    }
    value = object.subscriptionPlan;
    if (value != null) {
      result
        ..add('subscription_plan')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(SubscriptionModel),
          ),
        );
    }
    value = object.isSubscribed;
    if (value != null) {
      result
        ..add('is_subscribed')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.subscriptionEnd;
    if (value != null) {
      result
        ..add('subscription_end')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  ProfileModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ProfileModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'full_name':
          result.fullName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'gender':
          result.gender =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'image':
          result.image =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'payment':
          result.payment =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'phone_number':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'date_birth':
          result.dateBirth =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'sort_product':
          result.sortProduct =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'monthly_spend':
          result.monthlySpend =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'adult':
          result.adult =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'child':
          result.child =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'chat':
          result.chat =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'phone':
          result.phone =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'is_premium':
          result.isPremium =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'telegram':
          result.telegram =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'instagram':
          result.instagram =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'order_editable':
          result.orderEditable =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'user_address':
          result.userAddress.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(UserAddress),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'address':
          result.address.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(UserAddress),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'payment_choices':
          result.paymentChoices.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(PaymentChoicesModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'balance':
          result.balance =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'service':
          result.service.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(OrderReq),
                )!
                as OrderReq,
          );
          break;
        case 'support':
          result.support.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(SupportModel),
                )!
                as SupportModel,
          );
          break;
        case 'lang':
          result.lang =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'planned_orders':
          result.plannedOrders.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(PlannedOrderModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'subscription_plan':
          result.subscriptionPlan.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(SubscriptionModel),
                )!
                as SubscriptionModel,
          );
          break;
        case 'is_subscribed':
          result.isSubscribed =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'subscription_end':
          result.subscriptionEnd =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SupportModelSerializer implements StructuredSerializer<SupportModel> {
  @override
  final Iterable<Type> types = const [SupportModel, _$SupportModel];
  @override
  final String wireName = 'SupportModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SupportModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.callCenter;
    if (value != null) {
      result
        ..add('call_center')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.telegramBot;
    if (value != null) {
      result
        ..add('telegram_bot')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  SupportModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SupportModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'call_center':
          result.callCenter =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'telegram_bot':
          result.telegramBot =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentChoicesModelSerializer
    implements StructuredSerializer<PaymentChoicesModel> {
  @override
  final Iterable<Type> types = const [
    PaymentChoicesModel,
    _$PaymentChoicesModel,
  ];
  @override
  final String wireName = 'PaymentChoicesModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    PaymentChoicesModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.cardId;
    if (value != null) {
      result
        ..add('card_id')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.card;
    if (value != null) {
      result
        ..add('card')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.balance;
    if (value != null) {
      result
        ..add('balance')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    return result;
  }

  @override
  PaymentChoicesModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new PaymentChoicesModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'card_id':
          result.cardId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'card':
          result.card =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'balance':
          result.balance =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$CardModelSerializer implements StructuredSerializer<CardModel> {
  @override
  final Iterable<Type> types = const [CardModel, _$CardModel];
  @override
  final String wireName = 'CardModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CardModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.cardNumber;
    if (value != null) {
      result
        ..add('card_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.expireDate;
    if (value != null) {
      result
        ..add('expire_date')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.cvv;
    if (value != null) {
      result
        ..add('cvv')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.otpCode;
    if (value != null) {
      result
        ..add('otp_code')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  CardModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new CardModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'card_number':
          result.cardNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'expire_date':
          result.expireDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'cvv':
          result.cvv =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'otp_code':
          result.otpCode =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SubscriptionModelSerializer
    implements StructuredSerializer<SubscriptionModel> {
  @override
  final Iterable<Type> types = const [SubscriptionModel, _$SubscriptionModel];
  @override
  final String wireName = 'SubscriptionModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SubscriptionModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.durationDays;
    if (value != null) {
      result
        ..add('duration_days')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SubscriptionModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SubscriptionModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'price':
          result.price =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'created_at':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'duration_days':
          result.durationDays =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$SubscriptionReqSerializer
    implements StructuredSerializer<SubscriptionReq> {
  @override
  final Iterable<Type> types = const [SubscriptionReq, _$SubscriptionReq];
  @override
  final String wireName = 'SubscriptionReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SubscriptionReq object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.subscription;
    if (value != null) {
      result
        ..add('subscription')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.cardId;
    if (value != null) {
      result
        ..add('card_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.paymentId;
    if (value != null) {
      result
        ..add('payment_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SubscriptionReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SubscriptionReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'subscription':
          result.subscription =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'user':
          result.user =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'card_id':
          result.cardId =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'payment_id':
          result.paymentId =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$AppVersionModelSerializer
    implements StructuredSerializer<AppVersionModel> {
  @override
  final Iterable<Type> types = const [AppVersionModel, _$AppVersionModel];
  @override
  final String wireName = 'AppVersionModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    AppVersionModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.android;
    if (value != null) {
      result
        ..add('android')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.ios;
    if (value != null) {
      result
        ..add('ios')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  AppVersionModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new AppVersionModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'android':
          result.android =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'ios':
          result.ios =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$FCMTokenModelSerializer implements StructuredSerializer<FCMTokenModel> {
  @override
  final Iterable<Type> types = const [FCMTokenModel, _$FCMTokenModel];
  @override
  final String wireName = 'FCMTokenModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    FCMTokenModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.firebaseToken;
    if (value != null) {
      result
        ..add('firebase_token')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.platform;
    if (value != null) {
      result
        ..add('platform')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.lastVersion;
    if (value != null) {
      result
        ..add('last_version')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isCategoryGrid;
    if (value != null) {
      result
        ..add('is_category_grid')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.isProductGrid;
    if (value != null) {
      result
        ..add('is_product_grid')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    return result;
  }

  @override
  FCMTokenModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new FCMTokenModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'firebase_token':
          result.firebaseToken =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'platform':
          result.platform =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'last_version':
          result.lastVersion =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'is_category_grid':
          result.isCategoryGrid =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'is_product_grid':
          result.isProductGrid =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$VerificationSendReq extends VerificationSendReq {
  @override
  final String? phoneNumber;

  factory _$VerificationSendReq([
    void Function(VerificationSendReqBuilder)? updates,
  ]) => (new VerificationSendReqBuilder()..update(updates))._build();

  _$VerificationSendReq._({this.phoneNumber}) : super._();

  @override
  VerificationSendReq rebuild(
    void Function(VerificationSendReqBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerificationSendReqBuilder toBuilder() =>
      new VerificationSendReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerificationSendReq && phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerificationSendReq')
      ..add('phoneNumber', phoneNumber)).toString();
  }
}

class VerificationSendReqBuilder
    implements Builder<VerificationSendReq, VerificationSendReqBuilder> {
  _$VerificationSendReq? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  VerificationSendReqBuilder();

  VerificationSendReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerificationSendReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerificationSendReq;
  }

  @override
  void update(void Function(VerificationSendReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerificationSendReq build() => _build();

  _$VerificationSendReq _build() {
    final _$result =
        _$v ?? new _$VerificationSendReq._(phoneNumber: phoneNumber);
    replace(_$result);
    return _$result;
  }
}

class _$VerificationVerifyReq extends VerificationVerifyReq {
  @override
  final String? phoneNumber;
  @override
  final String? code;

  factory _$VerificationVerifyReq([
    void Function(VerificationVerifyReqBuilder)? updates,
  ]) => (new VerificationVerifyReqBuilder()..update(updates))._build();

  _$VerificationVerifyReq._({this.phoneNumber, this.code}) : super._();

  @override
  VerificationVerifyReq rebuild(
    void Function(VerificationVerifyReqBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerificationVerifyReqBuilder toBuilder() =>
      new VerificationVerifyReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerificationVerifyReq &&
        phoneNumber == other.phoneNumber &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerificationVerifyReq')
          ..add('phoneNumber', phoneNumber)
          ..add('code', code))
        .toString();
  }
}

class VerificationVerifyReqBuilder
    implements Builder<VerificationVerifyReq, VerificationVerifyReqBuilder> {
  _$VerificationVerifyReq? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  VerificationVerifyReqBuilder();

  VerificationVerifyReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerificationVerifyReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$VerificationVerifyReq;
  }

  @override
  void update(void Function(VerificationVerifyReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerificationVerifyReq build() => _build();

  _$VerificationVerifyReq _build() {
    final _$result =
        _$v ??
        new _$VerificationVerifyReq._(phoneNumber: phoneNumber, code: code);
    replace(_$result);
    return _$result;
  }
}

class _$RegisterReq extends RegisterReq {
  @override
  final String? fullName;
  @override
  final String? password;

  factory _$RegisterReq([void Function(RegisterReqBuilder)? updates]) =>
      (new RegisterReqBuilder()..update(updates))._build();

  _$RegisterReq._({this.fullName, this.password}) : super._();

  @override
  RegisterReq rebuild(void Function(RegisterReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterReqBuilder toBuilder() => new RegisterReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterReq &&
        fullName == other.fullName &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterReq')
          ..add('fullName', fullName)
          ..add('password', password))
        .toString();
  }
}

class RegisterReqBuilder implements Builder<RegisterReq, RegisterReqBuilder> {
  _$RegisterReq? _$v;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  RegisterReqBuilder();

  RegisterReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fullName = $v.fullName;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegisterReq;
  }

  @override
  void update(void Function(RegisterReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterReq build() => _build();

  _$RegisterReq _build() {
    final _$result =
        _$v ?? new _$RegisterReq._(fullName: fullName, password: password);
    replace(_$result);
    return _$result;
  }
}

class _$SignInReq extends SignInReq {
  @override
  final String? phoneNumber;
  @override
  final String? password;

  factory _$SignInReq([void Function(SignInReqBuilder)? updates]) =>
      (new SignInReqBuilder()..update(updates))._build();

  _$SignInReq._({this.phoneNumber, this.password}) : super._();

  @override
  SignInReq rebuild(void Function(SignInReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignInReqBuilder toBuilder() => new SignInReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInReq &&
        phoneNumber == other.phoneNumber &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignInReq')
          ..add('phoneNumber', phoneNumber)
          ..add('password', password))
        .toString();
  }
}

class SignInReqBuilder implements Builder<SignInReq, SignInReqBuilder> {
  _$SignInReq? _$v;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  SignInReqBuilder();

  SignInReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _phoneNumber = $v.phoneNumber;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignInReq;
  }

  @override
  void update(void Function(SignInReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignInReq build() => _build();

  _$SignInReq _build() {
    final _$result =
        _$v ?? new _$SignInReq._(phoneNumber: phoneNumber, password: password);
    replace(_$result);
    return _$result;
  }
}

class _$LoginRes extends LoginRes {
  @override
  final String? access;
  @override
  final String? refresh;
  @override
  final String? message;
  @override
  final bool? isUser;

  factory _$LoginRes([void Function(LoginResBuilder)? updates]) =>
      (new LoginResBuilder()..update(updates))._build();

  _$LoginRes._({this.access, this.refresh, this.message, this.isUser})
    : super._();

  @override
  LoginRes rebuild(void Function(LoginResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResBuilder toBuilder() => new LoginResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginRes &&
        access == other.access &&
        refresh == other.refresh &&
        message == other.message &&
        isUser == other.isUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, access.hashCode);
    _$hash = $jc(_$hash, refresh.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, isUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginRes')
          ..add('access', access)
          ..add('refresh', refresh)
          ..add('message', message)
          ..add('isUser', isUser))
        .toString();
  }
}

class LoginResBuilder implements Builder<LoginRes, LoginResBuilder> {
  _$LoginRes? _$v;

  String? _access;
  String? get access => _$this._access;
  set access(String? access) => _$this._access = access;

  String? _refresh;
  String? get refresh => _$this._refresh;
  set refresh(String? refresh) => _$this._refresh = refresh;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  bool? _isUser;
  bool? get isUser => _$this._isUser;
  set isUser(bool? isUser) => _$this._isUser = isUser;

  LoginResBuilder();

  LoginResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _access = $v.access;
      _refresh = $v.refresh;
      _message = $v.message;
      _isUser = $v.isUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginRes;
  }

  @override
  void update(void Function(LoginResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginRes build() => _build();

  _$LoginRes _build() {
    final _$result =
        _$v ??
        new _$LoginRes._(
          access: access,
          refresh: refresh,
          message: message,
          isUser: isUser,
        );
    replace(_$result);
    return _$result;
  }
}

class _$PasswordReq extends PasswordReq {
  @override
  final String? password;

  factory _$PasswordReq([void Function(PasswordReqBuilder)? updates]) =>
      (new PasswordReqBuilder()..update(updates))._build();

  _$PasswordReq._({this.password}) : super._();

  @override
  PasswordReq rebuild(void Function(PasswordReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordReqBuilder toBuilder() => new PasswordReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PasswordReq && password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PasswordReq')
      ..add('password', password)).toString();
  }
}

class PasswordReqBuilder implements Builder<PasswordReq, PasswordReqBuilder> {
  _$PasswordReq? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  PasswordReqBuilder();

  PasswordReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PasswordReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PasswordReq;
  }

  @override
  void update(void Function(PasswordReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PasswordReq build() => _build();

  _$PasswordReq _build() {
    final _$result = _$v ?? new _$PasswordReq._(password: password);
    replace(_$result);
    return _$result;
  }
}

class _$CheckAuthModel extends CheckAuthModel {
  @override
  final String? type;
  @override
  final String? detail;

  factory _$CheckAuthModel([void Function(CheckAuthModelBuilder)? updates]) =>
      (new CheckAuthModelBuilder()..update(updates))._build();

  _$CheckAuthModel._({this.type, this.detail}) : super._();

  @override
  CheckAuthModel rebuild(void Function(CheckAuthModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckAuthModelBuilder toBuilder() =>
      new CheckAuthModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckAuthModel &&
        type == other.type &&
        detail == other.detail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckAuthModel')
          ..add('type', type)
          ..add('detail', detail))
        .toString();
  }
}

class CheckAuthModelBuilder
    implements Builder<CheckAuthModel, CheckAuthModelBuilder> {
  _$CheckAuthModel? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  CheckAuthModelBuilder();

  CheckAuthModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _detail = $v.detail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckAuthModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CheckAuthModel;
  }

  @override
  void update(void Function(CheckAuthModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckAuthModel build() => _build();

  _$CheckAuthModel _build() {
    final _$result = _$v ?? new _$CheckAuthModel._(type: type, detail: detail);
    replace(_$result);
    return _$result;
  }
}

class _$ResetPasswordReq extends ResetPasswordReq {
  @override
  final String? oldPwd;
  @override
  final String? newPwd;

  factory _$ResetPasswordReq([
    void Function(ResetPasswordReqBuilder)? updates,
  ]) => (new ResetPasswordReqBuilder()..update(updates))._build();

  _$ResetPasswordReq._({this.oldPwd, this.newPwd}) : super._();

  @override
  ResetPasswordReq rebuild(void Function(ResetPasswordReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordReqBuilder toBuilder() =>
      new ResetPasswordReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordReq &&
        oldPwd == other.oldPwd &&
        newPwd == other.newPwd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oldPwd.hashCode);
    _$hash = $jc(_$hash, newPwd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPasswordReq')
          ..add('oldPwd', oldPwd)
          ..add('newPwd', newPwd))
        .toString();
  }
}

class ResetPasswordReqBuilder
    implements Builder<ResetPasswordReq, ResetPasswordReqBuilder> {
  _$ResetPasswordReq? _$v;

  String? _oldPwd;
  String? get oldPwd => _$this._oldPwd;
  set oldPwd(String? oldPwd) => _$this._oldPwd = oldPwd;

  String? _newPwd;
  String? get newPwd => _$this._newPwd;
  set newPwd(String? newPwd) => _$this._newPwd = newPwd;

  ResetPasswordReqBuilder();

  ResetPasswordReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oldPwd = $v.oldPwd;
      _newPwd = $v.newPwd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ResetPasswordReq;
  }

  @override
  void update(void Function(ResetPasswordReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordReq build() => _build();

  _$ResetPasswordReq _build() {
    final _$result =
        _$v ?? new _$ResetPasswordReq._(oldPwd: oldPwd, newPwd: newPwd);
    replace(_$result);
    return _$result;
  }
}

class _$ForgotPasswordReqModel extends ForgotPasswordReqModel {
  @override
  final String? code;
  @override
  final String? phone;
  @override
  final String? password;

  factory _$ForgotPasswordReqModel([
    void Function(ForgotPasswordReqModelBuilder)? updates,
  ]) => (new ForgotPasswordReqModelBuilder()..update(updates))._build();

  _$ForgotPasswordReqModel._({this.code, this.phone, this.password})
    : super._();

  @override
  ForgotPasswordReqModel rebuild(
    void Function(ForgotPasswordReqModelBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ForgotPasswordReqModelBuilder toBuilder() =>
      new ForgotPasswordReqModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgotPasswordReqModel &&
        code == other.code &&
        phone == other.phone &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForgotPasswordReqModel')
          ..add('code', code)
          ..add('phone', phone)
          ..add('password', password))
        .toString();
  }
}

class ForgotPasswordReqModelBuilder
    implements Builder<ForgotPasswordReqModel, ForgotPasswordReqModelBuilder> {
  _$ForgotPasswordReqModel? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  ForgotPasswordReqModelBuilder();

  ForgotPasswordReqModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _phone = $v.phone;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgotPasswordReqModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ForgotPasswordReqModel;
  }

  @override
  void update(void Function(ForgotPasswordReqModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgotPasswordReqModel build() => _build();

  _$ForgotPasswordReqModel _build() {
    final _$result =
        _$v ??
        new _$ForgotPasswordReqModel._(
          code: code,
          phone: phone,
          password: password,
        );
    replace(_$result);
    return _$result;
  }
}

class _$UserAddress extends UserAddress {
  @override
  final String? address;
  @override
  final String? addressName;
  @override
  final double? longitude;
  @override
  final double? latitude;
  @override
  final int? user;
  @override
  final int? id;
  @override
  final int? nearestWarehouse;
  @override
  final String? home;
  @override
  final String? entrance;
  @override
  final String? floor;
  @override
  final String? apartment;
  @override
  final String? comment;
  @override
  final int? addressType;
  @override
  final int? estimatedArrivalTime;
  @override
  final bool? disable;
  @override
  final String? entranceKey;

  factory _$UserAddress([void Function(UserAddressBuilder)? updates]) =>
      (new UserAddressBuilder()..update(updates))._build();

  _$UserAddress._({
    this.address,
    this.addressName,
    this.longitude,
    this.latitude,
    this.user,
    this.id,
    this.nearestWarehouse,
    this.home,
    this.entrance,
    this.floor,
    this.apartment,
    this.comment,
    this.addressType,
    this.estimatedArrivalTime,
    this.disable,
    this.entranceKey,
  }) : super._();

  @override
  UserAddress rebuild(void Function(UserAddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserAddressBuilder toBuilder() => new UserAddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserAddress &&
        address == other.address &&
        addressName == other.addressName &&
        longitude == other.longitude &&
        latitude == other.latitude &&
        user == other.user &&
        id == other.id &&
        nearestWarehouse == other.nearestWarehouse &&
        home == other.home &&
        entrance == other.entrance &&
        floor == other.floor &&
        apartment == other.apartment &&
        comment == other.comment &&
        addressType == other.addressType &&
        estimatedArrivalTime == other.estimatedArrivalTime &&
        disable == other.disable &&
        entranceKey == other.entranceKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, addressName.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, nearestWarehouse.hashCode);
    _$hash = $jc(_$hash, home.hashCode);
    _$hash = $jc(_$hash, entrance.hashCode);
    _$hash = $jc(_$hash, floor.hashCode);
    _$hash = $jc(_$hash, apartment.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, addressType.hashCode);
    _$hash = $jc(_$hash, estimatedArrivalTime.hashCode);
    _$hash = $jc(_$hash, disable.hashCode);
    _$hash = $jc(_$hash, entranceKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserAddress')
          ..add('address', address)
          ..add('addressName', addressName)
          ..add('longitude', longitude)
          ..add('latitude', latitude)
          ..add('user', user)
          ..add('id', id)
          ..add('nearestWarehouse', nearestWarehouse)
          ..add('home', home)
          ..add('entrance', entrance)
          ..add('floor', floor)
          ..add('apartment', apartment)
          ..add('comment', comment)
          ..add('addressType', addressType)
          ..add('estimatedArrivalTime', estimatedArrivalTime)
          ..add('disable', disable)
          ..add('entranceKey', entranceKey))
        .toString();
  }
}

class UserAddressBuilder implements Builder<UserAddress, UserAddressBuilder> {
  _$UserAddress? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _addressName;
  String? get addressName => _$this._addressName;
  set addressName(String? addressName) => _$this._addressName = addressName;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  int? _user;
  int? get user => _$this._user;
  set user(int? user) => _$this._user = user;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _nearestWarehouse;
  int? get nearestWarehouse => _$this._nearestWarehouse;
  set nearestWarehouse(int? nearestWarehouse) =>
      _$this._nearestWarehouse = nearestWarehouse;

  String? _home;
  String? get home => _$this._home;
  set home(String? home) => _$this._home = home;

  String? _entrance;
  String? get entrance => _$this._entrance;
  set entrance(String? entrance) => _$this._entrance = entrance;

  String? _floor;
  String? get floor => _$this._floor;
  set floor(String? floor) => _$this._floor = floor;

  String? _apartment;
  String? get apartment => _$this._apartment;
  set apartment(String? apartment) => _$this._apartment = apartment;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  int? _addressType;
  int? get addressType => _$this._addressType;
  set addressType(int? addressType) => _$this._addressType = addressType;

  int? _estimatedArrivalTime;
  int? get estimatedArrivalTime => _$this._estimatedArrivalTime;
  set estimatedArrivalTime(int? estimatedArrivalTime) =>
      _$this._estimatedArrivalTime = estimatedArrivalTime;

  bool? _disable;
  bool? get disable => _$this._disable;
  set disable(bool? disable) => _$this._disable = disable;

  String? _entranceKey;
  String? get entranceKey => _$this._entranceKey;
  set entranceKey(String? entranceKey) => _$this._entranceKey = entranceKey;

  UserAddressBuilder();

  UserAddressBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _addressName = $v.addressName;
      _longitude = $v.longitude;
      _latitude = $v.latitude;
      _user = $v.user;
      _id = $v.id;
      _nearestWarehouse = $v.nearestWarehouse;
      _home = $v.home;
      _entrance = $v.entrance;
      _floor = $v.floor;
      _apartment = $v.apartment;
      _comment = $v.comment;
      _addressType = $v.addressType;
      _estimatedArrivalTime = $v.estimatedArrivalTime;
      _disable = $v.disable;
      _entranceKey = $v.entranceKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserAddress other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserAddress;
  }

  @override
  void update(void Function(UserAddressBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserAddress build() => _build();

  _$UserAddress _build() {
    final _$result =
        _$v ??
        new _$UserAddress._(
          address: address,
          addressName: addressName,
          longitude: longitude,
          latitude: latitude,
          user: user,
          id: id,
          nearestWarehouse: nearestWarehouse,
          home: home,
          entrance: entrance,
          floor: floor,
          apartment: apartment,
          comment: comment,
          addressType: addressType,
          estimatedArrivalTime: estimatedArrivalTime,
          disable: disable,
          entranceKey: entranceKey,
        );
    replace(_$result);
    return _$result;
  }
}

class _$ProfileModel extends ProfileModel {
  @override
  final String? fullName;
  @override
  final String? gender;
  @override
  final String? image;
  @override
  final String? payment;
  @override
  final String? phoneNumber;
  @override
  final String? dateBirth;
  @override
  final int? sortProduct;
  @override
  final double? monthlySpend;
  @override
  final int? adult;
  @override
  final int? child;
  @override
  final bool? chat;
  @override
  final bool? phone;
  @override
  final bool? isPremium;
  @override
  final bool? telegram;
  @override
  final bool? instagram;
  @override
  final bool? orderEditable;
  @override
  final BuiltList<UserAddress>? userAddress;
  @override
  final BuiltList<UserAddress>? address;
  @override
  final BuiltList<PaymentChoicesModel>? paymentChoices;
  @override
  final double? balance;
  @override
  final OrderReq? service;
  @override
  final SupportModel? support;
  @override
  final String? lang;
  @override
  final BuiltList<PlannedOrderModel>? plannedOrders;
  @override
  final SubscriptionModel? subscriptionPlan;
  @override
  final bool? isSubscribed;
  @override
  final String? subscriptionEnd;

  factory _$ProfileModel([void Function(ProfileModelBuilder)? updates]) =>
      (new ProfileModelBuilder()..update(updates))._build();

  _$ProfileModel._({
    this.fullName,
    this.gender,
    this.image,
    this.payment,
    this.phoneNumber,
    this.dateBirth,
    this.sortProduct,
    this.monthlySpend,
    this.adult,
    this.child,
    this.chat,
    this.phone,
    this.isPremium,
    this.telegram,
    this.instagram,
    this.orderEditable,
    this.userAddress,
    this.address,
    this.paymentChoices,
    this.balance,
    this.service,
    this.support,
    this.lang,
    this.plannedOrders,
    this.subscriptionPlan,
    this.isSubscribed,
    this.subscriptionEnd,
  }) : super._();

  @override
  ProfileModel rebuild(void Function(ProfileModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileModelBuilder toBuilder() => new ProfileModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileModel &&
        fullName == other.fullName &&
        gender == other.gender &&
        image == other.image &&
        payment == other.payment &&
        phoneNumber == other.phoneNumber &&
        dateBirth == other.dateBirth &&
        sortProduct == other.sortProduct &&
        monthlySpend == other.monthlySpend &&
        adult == other.adult &&
        child == other.child &&
        chat == other.chat &&
        phone == other.phone &&
        isPremium == other.isPremium &&
        telegram == other.telegram &&
        instagram == other.instagram &&
        orderEditable == other.orderEditable &&
        userAddress == other.userAddress &&
        address == other.address &&
        paymentChoices == other.paymentChoices &&
        balance == other.balance &&
        service == other.service &&
        support == other.support &&
        lang == other.lang &&
        plannedOrders == other.plannedOrders &&
        subscriptionPlan == other.subscriptionPlan &&
        isSubscribed == other.isSubscribed &&
        subscriptionEnd == other.subscriptionEnd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, payment.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, dateBirth.hashCode);
    _$hash = $jc(_$hash, sortProduct.hashCode);
    _$hash = $jc(_$hash, monthlySpend.hashCode);
    _$hash = $jc(_$hash, adult.hashCode);
    _$hash = $jc(_$hash, child.hashCode);
    _$hash = $jc(_$hash, chat.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, isPremium.hashCode);
    _$hash = $jc(_$hash, telegram.hashCode);
    _$hash = $jc(_$hash, instagram.hashCode);
    _$hash = $jc(_$hash, orderEditable.hashCode);
    _$hash = $jc(_$hash, userAddress.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, paymentChoices.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, service.hashCode);
    _$hash = $jc(_$hash, support.hashCode);
    _$hash = $jc(_$hash, lang.hashCode);
    _$hash = $jc(_$hash, plannedOrders.hashCode);
    _$hash = $jc(_$hash, subscriptionPlan.hashCode);
    _$hash = $jc(_$hash, isSubscribed.hashCode);
    _$hash = $jc(_$hash, subscriptionEnd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileModel')
          ..add('fullName', fullName)
          ..add('gender', gender)
          ..add('image', image)
          ..add('payment', payment)
          ..add('phoneNumber', phoneNumber)
          ..add('dateBirth', dateBirth)
          ..add('sortProduct', sortProduct)
          ..add('monthlySpend', monthlySpend)
          ..add('adult', adult)
          ..add('child', child)
          ..add('chat', chat)
          ..add('phone', phone)
          ..add('isPremium', isPremium)
          ..add('telegram', telegram)
          ..add('instagram', instagram)
          ..add('orderEditable', orderEditable)
          ..add('userAddress', userAddress)
          ..add('address', address)
          ..add('paymentChoices', paymentChoices)
          ..add('balance', balance)
          ..add('service', service)
          ..add('support', support)
          ..add('lang', lang)
          ..add('plannedOrders', plannedOrders)
          ..add('subscriptionPlan', subscriptionPlan)
          ..add('isSubscribed', isSubscribed)
          ..add('subscriptionEnd', subscriptionEnd))
        .toString();
  }
}

class ProfileModelBuilder
    implements Builder<ProfileModel, ProfileModelBuilder> {
  _$ProfileModel? _$v;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _payment;
  String? get payment => _$this._payment;
  set payment(String? payment) => _$this._payment = payment;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _dateBirth;
  String? get dateBirth => _$this._dateBirth;
  set dateBirth(String? dateBirth) => _$this._dateBirth = dateBirth;

  int? _sortProduct;
  int? get sortProduct => _$this._sortProduct;
  set sortProduct(int? sortProduct) => _$this._sortProduct = sortProduct;

  double? _monthlySpend;
  double? get monthlySpend => _$this._monthlySpend;
  set monthlySpend(double? monthlySpend) => _$this._monthlySpend = monthlySpend;

  int? _adult;
  int? get adult => _$this._adult;
  set adult(int? adult) => _$this._adult = adult;

  int? _child;
  int? get child => _$this._child;
  set child(int? child) => _$this._child = child;

  bool? _chat;
  bool? get chat => _$this._chat;
  set chat(bool? chat) => _$this._chat = chat;

  bool? _phone;
  bool? get phone => _$this._phone;
  set phone(bool? phone) => _$this._phone = phone;

  bool? _isPremium;
  bool? get isPremium => _$this._isPremium;
  set isPremium(bool? isPremium) => _$this._isPremium = isPremium;

  bool? _telegram;
  bool? get telegram => _$this._telegram;
  set telegram(bool? telegram) => _$this._telegram = telegram;

  bool? _instagram;
  bool? get instagram => _$this._instagram;
  set instagram(bool? instagram) => _$this._instagram = instagram;

  bool? _orderEditable;
  bool? get orderEditable => _$this._orderEditable;
  set orderEditable(bool? orderEditable) =>
      _$this._orderEditable = orderEditable;

  ListBuilder<UserAddress>? _userAddress;
  ListBuilder<UserAddress> get userAddress =>
      _$this._userAddress ??= new ListBuilder<UserAddress>();
  set userAddress(ListBuilder<UserAddress>? userAddress) =>
      _$this._userAddress = userAddress;

  ListBuilder<UserAddress>? _address;
  ListBuilder<UserAddress> get address =>
      _$this._address ??= new ListBuilder<UserAddress>();
  set address(ListBuilder<UserAddress>? address) => _$this._address = address;

  ListBuilder<PaymentChoicesModel>? _paymentChoices;
  ListBuilder<PaymentChoicesModel> get paymentChoices =>
      _$this._paymentChoices ??= new ListBuilder<PaymentChoicesModel>();
  set paymentChoices(ListBuilder<PaymentChoicesModel>? paymentChoices) =>
      _$this._paymentChoices = paymentChoices;

  double? _balance;
  double? get balance => _$this._balance;
  set balance(double? balance) => _$this._balance = balance;

  OrderReqBuilder? _service;
  OrderReqBuilder get service => _$this._service ??= new OrderReqBuilder();
  set service(OrderReqBuilder? service) => _$this._service = service;

  SupportModelBuilder? _support;
  SupportModelBuilder get support =>
      _$this._support ??= new SupportModelBuilder();
  set support(SupportModelBuilder? support) => _$this._support = support;

  String? _lang;
  String? get lang => _$this._lang;
  set lang(String? lang) => _$this._lang = lang;

  ListBuilder<PlannedOrderModel>? _plannedOrders;
  ListBuilder<PlannedOrderModel> get plannedOrders =>
      _$this._plannedOrders ??= new ListBuilder<PlannedOrderModel>();
  set plannedOrders(ListBuilder<PlannedOrderModel>? plannedOrders) =>
      _$this._plannedOrders = plannedOrders;

  SubscriptionModelBuilder? _subscriptionPlan;
  SubscriptionModelBuilder get subscriptionPlan =>
      _$this._subscriptionPlan ??= new SubscriptionModelBuilder();
  set subscriptionPlan(SubscriptionModelBuilder? subscriptionPlan) =>
      _$this._subscriptionPlan = subscriptionPlan;

  bool? _isSubscribed;
  bool? get isSubscribed => _$this._isSubscribed;
  set isSubscribed(bool? isSubscribed) => _$this._isSubscribed = isSubscribed;

  String? _subscriptionEnd;
  String? get subscriptionEnd => _$this._subscriptionEnd;
  set subscriptionEnd(String? subscriptionEnd) =>
      _$this._subscriptionEnd = subscriptionEnd;

  ProfileModelBuilder();

  ProfileModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fullName = $v.fullName;
      _gender = $v.gender;
      _image = $v.image;
      _payment = $v.payment;
      _phoneNumber = $v.phoneNumber;
      _dateBirth = $v.dateBirth;
      _sortProduct = $v.sortProduct;
      _monthlySpend = $v.monthlySpend;
      _adult = $v.adult;
      _child = $v.child;
      _chat = $v.chat;
      _phone = $v.phone;
      _isPremium = $v.isPremium;
      _telegram = $v.telegram;
      _instagram = $v.instagram;
      _orderEditable = $v.orderEditable;
      _userAddress = $v.userAddress?.toBuilder();
      _address = $v.address?.toBuilder();
      _paymentChoices = $v.paymentChoices?.toBuilder();
      _balance = $v.balance;
      _service = $v.service?.toBuilder();
      _support = $v.support?.toBuilder();
      _lang = $v.lang;
      _plannedOrders = $v.plannedOrders?.toBuilder();
      _subscriptionPlan = $v.subscriptionPlan?.toBuilder();
      _isSubscribed = $v.isSubscribed;
      _subscriptionEnd = $v.subscriptionEnd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileModel;
  }

  @override
  void update(void Function(ProfileModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileModel build() => _build();

  _$ProfileModel _build() {
    _$ProfileModel _$result;
    try {
      _$result =
          _$v ??
          new _$ProfileModel._(
            fullName: fullName,
            gender: gender,
            image: image,
            payment: payment,
            phoneNumber: phoneNumber,
            dateBirth: dateBirth,
            sortProduct: sortProduct,
            monthlySpend: monthlySpend,
            adult: adult,
            child: child,
            chat: chat,
            phone: phone,
            isPremium: isPremium,
            telegram: telegram,
            instagram: instagram,
            orderEditable: orderEditable,
            userAddress: _userAddress?.build(),
            address: _address?.build(),
            paymentChoices: _paymentChoices?.build(),
            balance: balance,
            service: _service?.build(),
            support: _support?.build(),
            lang: lang,
            plannedOrders: _plannedOrders?.build(),
            subscriptionPlan: _subscriptionPlan?.build(),
            isSubscribed: isSubscribed,
            subscriptionEnd: subscriptionEnd,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userAddress';
        _userAddress?.build();
        _$failedField = 'address';
        _address?.build();
        _$failedField = 'paymentChoices';
        _paymentChoices?.build();

        _$failedField = 'service';
        _service?.build();
        _$failedField = 'support';
        _support?.build();

        _$failedField = 'plannedOrders';
        _plannedOrders?.build();
        _$failedField = 'subscriptionPlan';
        _subscriptionPlan?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ProfileModel',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SupportModel extends SupportModel {
  @override
  final String? callCenter;
  @override
  final String? telegramBot;

  factory _$SupportModel([void Function(SupportModelBuilder)? updates]) =>
      (new SupportModelBuilder()..update(updates))._build();

  _$SupportModel._({this.callCenter, this.telegramBot}) : super._();

  @override
  SupportModel rebuild(void Function(SupportModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SupportModelBuilder toBuilder() => new SupportModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SupportModel &&
        callCenter == other.callCenter &&
        telegramBot == other.telegramBot;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, callCenter.hashCode);
    _$hash = $jc(_$hash, telegramBot.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SupportModel')
          ..add('callCenter', callCenter)
          ..add('telegramBot', telegramBot))
        .toString();
  }
}

class SupportModelBuilder
    implements Builder<SupportModel, SupportModelBuilder> {
  _$SupportModel? _$v;

  String? _callCenter;
  String? get callCenter => _$this._callCenter;
  set callCenter(String? callCenter) => _$this._callCenter = callCenter;

  String? _telegramBot;
  String? get telegramBot => _$this._telegramBot;
  set telegramBot(String? telegramBot) => _$this._telegramBot = telegramBot;

  SupportModelBuilder();

  SupportModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _callCenter = $v.callCenter;
      _telegramBot = $v.telegramBot;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SupportModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SupportModel;
  }

  @override
  void update(void Function(SupportModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SupportModel build() => _build();

  _$SupportModel _build() {
    final _$result =
        _$v ??
        new _$SupportModel._(callCenter: callCenter, telegramBot: telegramBot);
    replace(_$result);
    return _$result;
  }
}

class _$PaymentChoicesModel extends PaymentChoicesModel {
  @override
  final int? id;
  @override
  final String? cardId;
  @override
  final String? card;
  @override
  final String? type;
  @override
  final double? balance;

  factory _$PaymentChoicesModel([
    void Function(PaymentChoicesModelBuilder)? updates,
  ]) => (new PaymentChoicesModelBuilder()..update(updates))._build();

  _$PaymentChoicesModel._({
    this.id,
    this.cardId,
    this.card,
    this.type,
    this.balance,
  }) : super._();

  @override
  PaymentChoicesModel rebuild(
    void Function(PaymentChoicesModelBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentChoicesModelBuilder toBuilder() =>
      new PaymentChoicesModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentChoicesModel &&
        id == other.id &&
        cardId == other.cardId &&
        card == other.card &&
        type == other.type &&
        balance == other.balance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, cardId.hashCode);
    _$hash = $jc(_$hash, card.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentChoicesModel')
          ..add('id', id)
          ..add('cardId', cardId)
          ..add('card', card)
          ..add('type', type)
          ..add('balance', balance))
        .toString();
  }
}

class PaymentChoicesModelBuilder
    implements Builder<PaymentChoicesModel, PaymentChoicesModelBuilder> {
  _$PaymentChoicesModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _cardId;
  String? get cardId => _$this._cardId;
  set cardId(String? cardId) => _$this._cardId = cardId;

  String? _card;
  String? get card => _$this._card;
  set card(String? card) => _$this._card = card;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  double? _balance;
  double? get balance => _$this._balance;
  set balance(double? balance) => _$this._balance = balance;

  PaymentChoicesModelBuilder();

  PaymentChoicesModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _cardId = $v.cardId;
      _card = $v.card;
      _type = $v.type;
      _balance = $v.balance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentChoicesModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentChoicesModel;
  }

  @override
  void update(void Function(PaymentChoicesModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentChoicesModel build() => _build();

  _$PaymentChoicesModel _build() {
    final _$result =
        _$v ??
        new _$PaymentChoicesModel._(
          id: id,
          cardId: cardId,
          card: card,
          type: type,
          balance: balance,
        );
    replace(_$result);
    return _$result;
  }
}

class _$CardModel extends CardModel {
  @override
  final String? cardNumber;
  @override
  final String? expireDate;
  @override
  final String? cvv;
  @override
  final String? otpCode;

  factory _$CardModel([void Function(CardModelBuilder)? updates]) =>
      (new CardModelBuilder()..update(updates))._build();

  _$CardModel._({this.cardNumber, this.expireDate, this.cvv, this.otpCode})
    : super._();

  @override
  CardModel rebuild(void Function(CardModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardModelBuilder toBuilder() => new CardModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardModel &&
        cardNumber == other.cardNumber &&
        expireDate == other.expireDate &&
        cvv == other.cvv &&
        otpCode == other.otpCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cardNumber.hashCode);
    _$hash = $jc(_$hash, expireDate.hashCode);
    _$hash = $jc(_$hash, cvv.hashCode);
    _$hash = $jc(_$hash, otpCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CardModel')
          ..add('cardNumber', cardNumber)
          ..add('expireDate', expireDate)
          ..add('cvv', cvv)
          ..add('otpCode', otpCode))
        .toString();
  }
}

class CardModelBuilder implements Builder<CardModel, CardModelBuilder> {
  _$CardModel? _$v;

  String? _cardNumber;
  String? get cardNumber => _$this._cardNumber;
  set cardNumber(String? cardNumber) => _$this._cardNumber = cardNumber;

  String? _expireDate;
  String? get expireDate => _$this._expireDate;
  set expireDate(String? expireDate) => _$this._expireDate = expireDate;

  String? _cvv;
  String? get cvv => _$this._cvv;
  set cvv(String? cvv) => _$this._cvv = cvv;

  String? _otpCode;
  String? get otpCode => _$this._otpCode;
  set otpCode(String? otpCode) => _$this._otpCode = otpCode;

  CardModelBuilder();

  CardModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cardNumber = $v.cardNumber;
      _expireDate = $v.expireDate;
      _cvv = $v.cvv;
      _otpCode = $v.otpCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CardModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CardModel;
  }

  @override
  void update(void Function(CardModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CardModel build() => _build();

  _$CardModel _build() {
    final _$result =
        _$v ??
        new _$CardModel._(
          cardNumber: cardNumber,
          expireDate: expireDate,
          cvv: cvv,
          otpCode: otpCode,
        );
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionModel extends SubscriptionModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final double? price;
  @override
  final String? createdAt;
  @override
  final String? name;
  @override
  final int? durationDays;

  factory _$SubscriptionModel([
    void Function(SubscriptionModelBuilder)? updates,
  ]) => (new SubscriptionModelBuilder()..update(updates))._build();

  _$SubscriptionModel._({
    this.id,
    this.title,
    this.price,
    this.createdAt,
    this.name,
    this.durationDays,
  }) : super._();

  @override
  SubscriptionModel rebuild(void Function(SubscriptionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionModelBuilder toBuilder() =>
      new SubscriptionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionModel &&
        id == other.id &&
        title == other.title &&
        price == other.price &&
        createdAt == other.createdAt &&
        name == other.name &&
        durationDays == other.durationDays;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, durationDays.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubscriptionModel')
          ..add('id', id)
          ..add('title', title)
          ..add('price', price)
          ..add('createdAt', createdAt)
          ..add('name', name)
          ..add('durationDays', durationDays))
        .toString();
  }
}

class SubscriptionModelBuilder
    implements Builder<SubscriptionModel, SubscriptionModelBuilder> {
  _$SubscriptionModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _durationDays;
  int? get durationDays => _$this._durationDays;
  set durationDays(int? durationDays) => _$this._durationDays = durationDays;

  SubscriptionModelBuilder();

  SubscriptionModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _price = $v.price;
      _createdAt = $v.createdAt;
      _name = $v.name;
      _durationDays = $v.durationDays;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubscriptionModel;
  }

  @override
  void update(void Function(SubscriptionModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionModel build() => _build();

  _$SubscriptionModel _build() {
    final _$result =
        _$v ??
        new _$SubscriptionModel._(
          id: id,
          title: title,
          price: price,
          createdAt: createdAt,
          name: name,
          durationDays: durationDays,
        );
    replace(_$result);
    return _$result;
  }
}

class _$SubscriptionReq extends SubscriptionReq {
  @override
  final int? subscription;
  @override
  final int? user;
  @override
  final int? cardId;
  @override
  final int? paymentId;

  factory _$SubscriptionReq([void Function(SubscriptionReqBuilder)? updates]) =>
      (new SubscriptionReqBuilder()..update(updates))._build();

  _$SubscriptionReq._({
    this.subscription,
    this.user,
    this.cardId,
    this.paymentId,
  }) : super._();

  @override
  SubscriptionReq rebuild(void Function(SubscriptionReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubscriptionReqBuilder toBuilder() =>
      new SubscriptionReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubscriptionReq &&
        subscription == other.subscription &&
        user == other.user &&
        cardId == other.cardId &&
        paymentId == other.paymentId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subscription.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, cardId.hashCode);
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubscriptionReq')
          ..add('subscription', subscription)
          ..add('user', user)
          ..add('cardId', cardId)
          ..add('paymentId', paymentId))
        .toString();
  }
}

class SubscriptionReqBuilder
    implements Builder<SubscriptionReq, SubscriptionReqBuilder> {
  _$SubscriptionReq? _$v;

  int? _subscription;
  int? get subscription => _$this._subscription;
  set subscription(int? subscription) => _$this._subscription = subscription;

  int? _user;
  int? get user => _$this._user;
  set user(int? user) => _$this._user = user;

  int? _cardId;
  int? get cardId => _$this._cardId;
  set cardId(int? cardId) => _$this._cardId = cardId;

  int? _paymentId;
  int? get paymentId => _$this._paymentId;
  set paymentId(int? paymentId) => _$this._paymentId = paymentId;

  SubscriptionReqBuilder();

  SubscriptionReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subscription = $v.subscription;
      _user = $v.user;
      _cardId = $v.cardId;
      _paymentId = $v.paymentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubscriptionReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubscriptionReq;
  }

  @override
  void update(void Function(SubscriptionReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubscriptionReq build() => _build();

  _$SubscriptionReq _build() {
    final _$result =
        _$v ??
        new _$SubscriptionReq._(
          subscription: subscription,
          user: user,
          cardId: cardId,
          paymentId: paymentId,
        );
    replace(_$result);
    return _$result;
  }
}

class _$AppVersionModel extends AppVersionModel {
  @override
  final String? android;
  @override
  final String? ios;

  factory _$AppVersionModel([void Function(AppVersionModelBuilder)? updates]) =>
      (new AppVersionModelBuilder()..update(updates))._build();

  _$AppVersionModel._({this.android, this.ios}) : super._();

  @override
  AppVersionModel rebuild(void Function(AppVersionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppVersionModelBuilder toBuilder() =>
      new AppVersionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppVersionModel &&
        android == other.android &&
        ios == other.ios;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, android.hashCode);
    _$hash = $jc(_$hash, ios.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppVersionModel')
          ..add('android', android)
          ..add('ios', ios))
        .toString();
  }
}

class AppVersionModelBuilder
    implements Builder<AppVersionModel, AppVersionModelBuilder> {
  _$AppVersionModel? _$v;

  String? _android;
  String? get android => _$this._android;
  set android(String? android) => _$this._android = android;

  String? _ios;
  String? get ios => _$this._ios;
  set ios(String? ios) => _$this._ios = ios;

  AppVersionModelBuilder();

  AppVersionModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _android = $v.android;
      _ios = $v.ios;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppVersionModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppVersionModel;
  }

  @override
  void update(void Function(AppVersionModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppVersionModel build() => _build();

  _$AppVersionModel _build() {
    final _$result = _$v ?? new _$AppVersionModel._(android: android, ios: ios);
    replace(_$result);
    return _$result;
  }
}

class _$FCMTokenModel extends FCMTokenModel {
  @override
  final String? firebaseToken;
  @override
  final String? platform;
  @override
  final String? lastVersion;
  @override
  final bool? isCategoryGrid;
  @override
  final bool? isProductGrid;

  factory _$FCMTokenModel([void Function(FCMTokenModelBuilder)? updates]) =>
      (new FCMTokenModelBuilder()..update(updates))._build();

  _$FCMTokenModel._({
    this.firebaseToken,
    this.platform,
    this.lastVersion,
    this.isCategoryGrid,
    this.isProductGrid,
  }) : super._();

  @override
  FCMTokenModel rebuild(void Function(FCMTokenModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FCMTokenModelBuilder toBuilder() => new FCMTokenModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FCMTokenModel &&
        firebaseToken == other.firebaseToken &&
        platform == other.platform &&
        lastVersion == other.lastVersion &&
        isCategoryGrid == other.isCategoryGrid &&
        isProductGrid == other.isProductGrid;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firebaseToken.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, lastVersion.hashCode);
    _$hash = $jc(_$hash, isCategoryGrid.hashCode);
    _$hash = $jc(_$hash, isProductGrid.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FCMTokenModel')
          ..add('firebaseToken', firebaseToken)
          ..add('platform', platform)
          ..add('lastVersion', lastVersion)
          ..add('isCategoryGrid', isCategoryGrid)
          ..add('isProductGrid', isProductGrid))
        .toString();
  }
}

class FCMTokenModelBuilder
    implements Builder<FCMTokenModel, FCMTokenModelBuilder> {
  _$FCMTokenModel? _$v;

  String? _firebaseToken;
  String? get firebaseToken => _$this._firebaseToken;
  set firebaseToken(String? firebaseToken) =>
      _$this._firebaseToken = firebaseToken;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _lastVersion;
  String? get lastVersion => _$this._lastVersion;
  set lastVersion(String? lastVersion) => _$this._lastVersion = lastVersion;

  bool? _isCategoryGrid;
  bool? get isCategoryGrid => _$this._isCategoryGrid;
  set isCategoryGrid(bool? isCategoryGrid) =>
      _$this._isCategoryGrid = isCategoryGrid;

  bool? _isProductGrid;
  bool? get isProductGrid => _$this._isProductGrid;
  set isProductGrid(bool? isProductGrid) =>
      _$this._isProductGrid = isProductGrid;

  FCMTokenModelBuilder();

  FCMTokenModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firebaseToken = $v.firebaseToken;
      _platform = $v.platform;
      _lastVersion = $v.lastVersion;
      _isCategoryGrid = $v.isCategoryGrid;
      _isProductGrid = $v.isProductGrid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FCMTokenModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FCMTokenModel;
  }

  @override
  void update(void Function(FCMTokenModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FCMTokenModel build() => _build();

  _$FCMTokenModel _build() {
    final _$result =
        _$v ??
        new _$FCMTokenModel._(
          firebaseToken: firebaseToken,
          platform: platform,
          lastVersion: lastVersion,
          isCategoryGrid: isCategoryGrid,
          isProductGrid: isProductGrid,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
