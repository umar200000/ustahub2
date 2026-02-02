import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ustahub/domain/serializers/serializer.dart';

part 'main_model.g.dart';

abstract class CurrencyModel
    implements Built<CurrencyModel, CurrencyModelBuilder> {
  CurrencyModel._();

  factory CurrencyModel([Function(CurrencyModelBuilder b) updates]) =
      _$CurrencyModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'amount')
  double? get amount;

  String toJson() {
    return json.encode(
      serializers.serializeWith(CurrencyModel.serializer, this),
    );
  }

  static CurrencyModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
      CurrencyModel.serializer,
      json.decode(jsonString),
    );
  }

  static Serializer<CurrencyModel> get serializer => _$currencyModelSerializer;
}

abstract class ImagesModel implements Built<ImagesModel, ImagesModelBuilder> {
  ImagesModel._();

  factory ImagesModel([Function(ImagesModelBuilder b) updates]) = _$ImagesModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'url')
  String? get url;

  @BuiltValueField(wireName: 'thumbnail')
  String? get thumbnail;

  @BuiltValueField(wireName: 'type')
  String? get type;

  @BuiltValueField(wireName: 'car')
  int? get car;

  static Serializer<ImagesModel> get serializer => _$imagesModelSerializer;
}

abstract class MonitoringModel
    implements Built<MonitoringModel, MonitoringModelBuilder> {
  MonitoringModel._();

  factory MonitoringModel([Function(MonitoringModelBuilder b) updates]) =
      _$MonitoringModel;

  @BuiltValueField(wireName: 'cash')
  double? get cash;

  @BuiltValueField(wireName: 'card')
  double? get card;

  @BuiltValueField(wireName: 'total')
  double? get total;

  @BuiltValueField(wireName: 'orders')
  BuiltList<MonitoringOrderModel>? get orders;

  static Serializer<MonitoringModel> get serializer =>
      _$monitoringModelSerializer;
}

abstract class MonitoringOrderModel
    implements Built<MonitoringOrderModel, MonitoringOrderModelBuilder> {
  MonitoringOrderModel._();

  factory MonitoringOrderModel([
    Function(MonitoringOrderModelBuilder b) updates,
  ]) = _$MonitoringOrderModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'payment')
  int? get payment;

  @BuiltValueField(wireName: 'check_number')
  String? get checkNumber;

  @BuiltValueField(wireName: 'amount_to_pay')
  double? get amountToPay;

  @BuiltValueField(wireName: 'actual_order_create_time')
  String? get actualOrderCreateTime;

  @BuiltValueField(wireName: 'payment_type')
  String? get paymentType;

  static Serializer<MonitoringOrderModel> get serializer =>
      _$monitoringOrderModelSerializer;
}
