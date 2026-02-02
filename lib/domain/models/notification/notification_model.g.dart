// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Notification> _$notificationSerializer =
    new _$NotificationSerializer();
Serializer<NotificationModel> _$notificationModelSerializer =
    new _$NotificationModelSerializer();

class _$NotificationSerializer implements StructuredSerializer<Notification> {
  @override
  final Iterable<Type> types = const [Notification, _$Notification];
  @override
  final String wireName = 'Notification';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Notification object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.results;
    if (value != null) {
      result
        ..add('results')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(NotificationModel),
            ]),
          ),
        );
    }
    value = object.totalPages;
    if (value != null) {
      result
        ..add('total_pages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.page;
    if (value != null) {
      result
        ..add('page')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Notification deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new NotificationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'results':
          result.results.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(NotificationModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'total_pages':
          result.totalPages =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'page':
          result.page =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'count':
          result.count =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$NotificationModelSerializer
    implements StructuredSerializer<NotificationModel> {
  @override
  final Iterable<Type> types = const [NotificationModel, _$NotificationModel];
  @override
  final String wireName = 'NotificationModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    NotificationModel object, {
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
    value = object.body;
    if (value != null) {
      result
        ..add('body')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isRead;
    if (value != null) {
      result
        ..add('is_read')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
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
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  NotificationModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new NotificationModelBuilder();

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
        case 'body':
          result.body =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'is_read':
          result.isRead =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'image':
          result.image =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'date':
          result.date =
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

class _$Notification extends Notification {
  @override
  final BuiltList<NotificationModel>? results;
  @override
  final int? totalPages;
  @override
  final int? page;
  @override
  final int? count;

  factory _$Notification([void Function(NotificationBuilder)? updates]) =>
      (new NotificationBuilder()..update(updates))._build();

  _$Notification._({this.results, this.totalPages, this.page, this.count})
    : super._();

  @override
  Notification rebuild(void Function(NotificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationBuilder toBuilder() => new NotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Notification &&
        results == other.results &&
        totalPages == other.totalPages &&
        page == other.page &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Notification')
          ..add('results', results)
          ..add('totalPages', totalPages)
          ..add('page', page)
          ..add('count', count))
        .toString();
  }
}

class NotificationBuilder
    implements Builder<Notification, NotificationBuilder> {
  _$Notification? _$v;

  ListBuilder<NotificationModel>? _results;
  ListBuilder<NotificationModel> get results =>
      _$this._results ??= new ListBuilder<NotificationModel>();
  set results(ListBuilder<NotificationModel>? results) =>
      _$this._results = results;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  NotificationBuilder();

  NotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _results = $v.results?.toBuilder();
      _totalPages = $v.totalPages;
      _page = $v.page;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Notification other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Notification;
  }

  @override
  void update(void Function(NotificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Notification build() => _build();

  _$Notification _build() {
    _$Notification _$result;
    try {
      _$result =
          _$v ??
          new _$Notification._(
            results: _results?.build(),
            totalPages: totalPages,
            page: page,
            count: count,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'Notification',
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

class _$NotificationModel extends NotificationModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final bool? isRead;
  @override
  final String? image;
  @override
  final String? date;

  factory _$NotificationModel([
    void Function(NotificationModelBuilder)? updates,
  ]) => (new NotificationModelBuilder()..update(updates))._build();

  _$NotificationModel._({
    this.id,
    this.title,
    this.body,
    this.isRead,
    this.image,
    this.date,
  }) : super._();

  @override
  NotificationModel rebuild(void Function(NotificationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationModelBuilder toBuilder() =>
      new NotificationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationModel &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        isRead == other.isRead &&
        image == other.image &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationModel')
          ..add('id', id)
          ..add('title', title)
          ..add('body', body)
          ..add('isRead', isRead)
          ..add('image', image)
          ..add('date', date))
        .toString();
  }
}

class NotificationModelBuilder
    implements Builder<NotificationModel, NotificationModelBuilder> {
  _$NotificationModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  NotificationModelBuilder();

  NotificationModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _body = $v.body;
      _isRead = $v.isRead;
      _image = $v.image;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NotificationModel;
  }

  @override
  void update(void Function(NotificationModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationModel build() => _build();

  _$NotificationModel _build() {
    final _$result =
        _$v ??
        new _$NotificationModel._(
          id: id,
          title: title,
          body: body,
          isRead: isRead,
          image: image,
          date: date,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
