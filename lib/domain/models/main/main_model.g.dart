// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CurrencyModel> _$currencyModelSerializer =
    new _$CurrencyModelSerializer();
Serializer<ImagesModel> _$imagesModelSerializer = new _$ImagesModelSerializer();
Serializer<MonitoringModel> _$monitoringModelSerializer =
    new _$MonitoringModelSerializer();
Serializer<MonitoringOrderModel> _$monitoringOrderModelSerializer =
    new _$MonitoringOrderModelSerializer();

class _$CurrencyModelSerializer implements StructuredSerializer<CurrencyModel> {
  @override
  final Iterable<Type> types = const [CurrencyModel, _$CurrencyModel];
  @override
  final String wireName = 'CurrencyModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CurrencyModel object, {
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
    value = object.amount;
    if (value != null) {
      result
        ..add('amount')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    return result;
  }

  @override
  CurrencyModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new CurrencyModelBuilder();

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
        case 'amount':
          result.amount =
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

class _$ImagesModelSerializer implements StructuredSerializer<ImagesModel> {
  @override
  final Iterable<Type> types = const [ImagesModel, _$ImagesModel];
  @override
  final String wireName = 'ImagesModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ImagesModel object, {
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
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.thumbnail;
    if (value != null) {
      result
        ..add('thumbnail')
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
    value = object.car;
    if (value != null) {
      result
        ..add('car')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ImagesModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ImagesModelBuilder();

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
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'thumbnail':
          result.thumbnail =
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
        case 'car':
          result.car =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$MonitoringModelSerializer
    implements StructuredSerializer<MonitoringModel> {
  @override
  final Iterable<Type> types = const [MonitoringModel, _$MonitoringModel];
  @override
  final String wireName = 'MonitoringModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    MonitoringModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.cash;
    if (value != null) {
      result
        ..add('cash')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.card;
    if (value != null) {
      result
        ..add('card')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.total;
    if (value != null) {
      result
        ..add('total')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.orders;
    if (value != null) {
      result
        ..add('orders')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(MonitoringOrderModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  MonitoringModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new MonitoringModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'cash':
          result.cash =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'card':
          result.card =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'total':
          result.total =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'orders':
          result.orders.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(MonitoringOrderModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$MonitoringOrderModelSerializer
    implements StructuredSerializer<MonitoringOrderModel> {
  @override
  final Iterable<Type> types = const [
    MonitoringOrderModel,
    _$MonitoringOrderModel,
  ];
  @override
  final String wireName = 'MonitoringOrderModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    MonitoringOrderModel object, {
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
    value = object.payment;
    if (value != null) {
      result
        ..add('payment')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.checkNumber;
    if (value != null) {
      result
        ..add('check_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.amountToPay;
    if (value != null) {
      result
        ..add('amount_to_pay')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.actualOrderCreateTime;
    if (value != null) {
      result
        ..add('actual_order_create_time')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.paymentType;
    if (value != null) {
      result
        ..add('payment_type')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  MonitoringOrderModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new MonitoringOrderModelBuilder();

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
        case 'payment':
          result.payment =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'check_number':
          result.checkNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'amount_to_pay':
          result.amountToPay =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'actual_order_create_time':
          result.actualOrderCreateTime =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'payment_type':
          result.paymentType =
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

class _$CurrencyModel extends CurrencyModel {
  @override
  final int? id;
  @override
  final double? amount;

  factory _$CurrencyModel([void Function(CurrencyModelBuilder)? updates]) =>
      (new CurrencyModelBuilder()..update(updates))._build();

  _$CurrencyModel._({this.id, this.amount}) : super._();

  @override
  CurrencyModel rebuild(void Function(CurrencyModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyModelBuilder toBuilder() => new CurrencyModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyModel && id == other.id && amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CurrencyModel')
          ..add('id', id)
          ..add('amount', amount))
        .toString();
  }
}

class CurrencyModelBuilder
    implements Builder<CurrencyModel, CurrencyModelBuilder> {
  _$CurrencyModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  CurrencyModelBuilder();

  CurrencyModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrencyModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CurrencyModel;
  }

  @override
  void update(void Function(CurrencyModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrencyModel build() => _build();

  _$CurrencyModel _build() {
    final _$result = _$v ?? new _$CurrencyModel._(id: id, amount: amount);
    replace(_$result);
    return _$result;
  }
}

class _$ImagesModel extends ImagesModel {
  @override
  final int? id;
  @override
  final String? url;
  @override
  final String? thumbnail;
  @override
  final String? type;
  @override
  final int? car;

  factory _$ImagesModel([void Function(ImagesModelBuilder)? updates]) =>
      (new ImagesModelBuilder()..update(updates))._build();

  _$ImagesModel._({this.id, this.url, this.thumbnail, this.type, this.car})
    : super._();

  @override
  ImagesModel rebuild(void Function(ImagesModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImagesModelBuilder toBuilder() => new ImagesModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImagesModel &&
        id == other.id &&
        url == other.url &&
        thumbnail == other.thumbnail &&
        type == other.type &&
        car == other.car;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, thumbnail.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, car.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImagesModel')
          ..add('id', id)
          ..add('url', url)
          ..add('thumbnail', thumbnail)
          ..add('type', type)
          ..add('car', car))
        .toString();
  }
}

class ImagesModelBuilder implements Builder<ImagesModel, ImagesModelBuilder> {
  _$ImagesModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _thumbnail;
  String? get thumbnail => _$this._thumbnail;
  set thumbnail(String? thumbnail) => _$this._thumbnail = thumbnail;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _car;
  int? get car => _$this._car;
  set car(int? car) => _$this._car = car;

  ImagesModelBuilder();

  ImagesModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _url = $v.url;
      _thumbnail = $v.thumbnail;
      _type = $v.type;
      _car = $v.car;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImagesModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImagesModel;
  }

  @override
  void update(void Function(ImagesModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImagesModel build() => _build();

  _$ImagesModel _build() {
    final _$result =
        _$v ??
        new _$ImagesModel._(
          id: id,
          url: url,
          thumbnail: thumbnail,
          type: type,
          car: car,
        );
    replace(_$result);
    return _$result;
  }
}

class _$MonitoringModel extends MonitoringModel {
  @override
  final double? cash;
  @override
  final double? card;
  @override
  final double? total;
  @override
  final BuiltList<MonitoringOrderModel>? orders;

  factory _$MonitoringModel([void Function(MonitoringModelBuilder)? updates]) =>
      (new MonitoringModelBuilder()..update(updates))._build();

  _$MonitoringModel._({this.cash, this.card, this.total, this.orders})
    : super._();

  @override
  MonitoringModel rebuild(void Function(MonitoringModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonitoringModelBuilder toBuilder() =>
      new MonitoringModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonitoringModel &&
        cash == other.cash &&
        card == other.card &&
        total == other.total &&
        orders == other.orders;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cash.hashCode);
    _$hash = $jc(_$hash, card.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, orders.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonitoringModel')
          ..add('cash', cash)
          ..add('card', card)
          ..add('total', total)
          ..add('orders', orders))
        .toString();
  }
}

class MonitoringModelBuilder
    implements Builder<MonitoringModel, MonitoringModelBuilder> {
  _$MonitoringModel? _$v;

  double? _cash;
  double? get cash => _$this._cash;
  set cash(double? cash) => _$this._cash = cash;

  double? _card;
  double? get card => _$this._card;
  set card(double? card) => _$this._card = card;

  double? _total;
  double? get total => _$this._total;
  set total(double? total) => _$this._total = total;

  ListBuilder<MonitoringOrderModel>? _orders;
  ListBuilder<MonitoringOrderModel> get orders =>
      _$this._orders ??= new ListBuilder<MonitoringOrderModel>();
  set orders(ListBuilder<MonitoringOrderModel>? orders) =>
      _$this._orders = orders;

  MonitoringModelBuilder();

  MonitoringModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cash = $v.cash;
      _card = $v.card;
      _total = $v.total;
      _orders = $v.orders?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonitoringModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MonitoringModel;
  }

  @override
  void update(void Function(MonitoringModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonitoringModel build() => _build();

  _$MonitoringModel _build() {
    _$MonitoringModel _$result;
    try {
      _$result =
          _$v ??
          new _$MonitoringModel._(
            cash: cash,
            card: card,
            total: total,
            orders: _orders?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orders';
        _orders?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'MonitoringModel',
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

class _$MonitoringOrderModel extends MonitoringOrderModel {
  @override
  final int? id;
  @override
  final int? payment;
  @override
  final String? checkNumber;
  @override
  final double? amountToPay;
  @override
  final String? actualOrderCreateTime;
  @override
  final String? paymentType;

  factory _$MonitoringOrderModel([
    void Function(MonitoringOrderModelBuilder)? updates,
  ]) => (new MonitoringOrderModelBuilder()..update(updates))._build();

  _$MonitoringOrderModel._({
    this.id,
    this.payment,
    this.checkNumber,
    this.amountToPay,
    this.actualOrderCreateTime,
    this.paymentType,
  }) : super._();

  @override
  MonitoringOrderModel rebuild(
    void Function(MonitoringOrderModelBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MonitoringOrderModelBuilder toBuilder() =>
      new MonitoringOrderModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonitoringOrderModel &&
        id == other.id &&
        payment == other.payment &&
        checkNumber == other.checkNumber &&
        amountToPay == other.amountToPay &&
        actualOrderCreateTime == other.actualOrderCreateTime &&
        paymentType == other.paymentType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, payment.hashCode);
    _$hash = $jc(_$hash, checkNumber.hashCode);
    _$hash = $jc(_$hash, amountToPay.hashCode);
    _$hash = $jc(_$hash, actualOrderCreateTime.hashCode);
    _$hash = $jc(_$hash, paymentType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonitoringOrderModel')
          ..add('id', id)
          ..add('payment', payment)
          ..add('checkNumber', checkNumber)
          ..add('amountToPay', amountToPay)
          ..add('actualOrderCreateTime', actualOrderCreateTime)
          ..add('paymentType', paymentType))
        .toString();
  }
}

class MonitoringOrderModelBuilder
    implements Builder<MonitoringOrderModel, MonitoringOrderModelBuilder> {
  _$MonitoringOrderModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _payment;
  int? get payment => _$this._payment;
  set payment(int? payment) => _$this._payment = payment;

  String? _checkNumber;
  String? get checkNumber => _$this._checkNumber;
  set checkNumber(String? checkNumber) => _$this._checkNumber = checkNumber;

  double? _amountToPay;
  double? get amountToPay => _$this._amountToPay;
  set amountToPay(double? amountToPay) => _$this._amountToPay = amountToPay;

  String? _actualOrderCreateTime;
  String? get actualOrderCreateTime => _$this._actualOrderCreateTime;
  set actualOrderCreateTime(String? actualOrderCreateTime) =>
      _$this._actualOrderCreateTime = actualOrderCreateTime;

  String? _paymentType;
  String? get paymentType => _$this._paymentType;
  set paymentType(String? paymentType) => _$this._paymentType = paymentType;

  MonitoringOrderModelBuilder();

  MonitoringOrderModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _payment = $v.payment;
      _checkNumber = $v.checkNumber;
      _amountToPay = $v.amountToPay;
      _actualOrderCreateTime = $v.actualOrderCreateTime;
      _paymentType = $v.paymentType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonitoringOrderModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MonitoringOrderModel;
  }

  @override
  void update(void Function(MonitoringOrderModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonitoringOrderModel build() => _build();

  _$MonitoringOrderModel _build() {
    final _$result =
        _$v ??
        new _$MonitoringOrderModel._(
          id: id,
          payment: payment,
          checkNumber: checkNumber,
          amountToPay: amountToPay,
          actualOrderCreateTime: actualOrderCreateTime,
          paymentType: paymentType,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
