// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BannerModel> _$bannerModelSerializer = new _$BannerModelSerializer();
Serializer<SetModel> _$setModelSerializer = new _$SetModelSerializer();
Serializer<StoryModel> _$storyModelSerializer = new _$StoryModelSerializer();
Serializer<StoryItemModel> _$storyItemModelSerializer =
    new _$StoryItemModelSerializer();
Serializer<FilterRes> _$filterResSerializer = new _$FilterResSerializer();
Serializer<FilterItemModel> _$filterItemModelSerializer =
    new _$FilterItemModelSerializer();
Serializer<SearchModel> _$searchModelSerializer = new _$SearchModelSerializer();
Serializer<BrandData> _$brandDataSerializer = new _$BrandDataSerializer();

class _$BannerModelSerializer implements StructuredSerializer<BannerModel> {
  @override
  final Iterable<Type> types = const [BannerModel, _$BannerModel];
  @override
  final String wireName = 'BannerModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    BannerModel object, {
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
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.priority;
    if (value != null) {
      result
        ..add('priority')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  BannerModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new BannerModelBuilder();

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
        case 'brand':
          result.brand =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'image':
          result.image =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'priority':
          result.priority =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$SetModelSerializer implements StructuredSerializer<SetModel> {
  @override
  final Iterable<Type> types = const [SetModel, _$SetModel];
  @override
  final String wireName = 'SetModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SetModel object, {
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
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
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
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.priority;
    if (value != null) {
      result
        ..add('priority')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  SetModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SetModelBuilder();

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
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'description':
          result.description =
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
        case 'icon':
          result.icon =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'priority':
          result.priority =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'created_at':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'updated_at':
          result.updatedAt =
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

class _$StoryModelSerializer implements StructuredSerializer<StoryModel> {
  @override
  final Iterable<Type> types = const [StoryModel, _$StoryModel];
  @override
  final String wireName = 'StoryModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    StoryModel object, {
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
    value = object.count;
    if (value != null) {
      result
        ..add('count')
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
    value = object.description;
    if (value != null) {
      result
        ..add('description')
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
    value = object.stories;
    if (value != null) {
      result
        ..add('stories')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(StoryItemModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  StoryModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new StoryModelBuilder();

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
        case 'count':
          result.count =
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
        case 'description':
          result.description =
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
        case 'stories':
          result.stories.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(StoryItemModel),
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

class _$StoryItemModelSerializer
    implements StructuredSerializer<StoryItemModel> {
  @override
  final Iterable<Type> types = const [StoryItemModel, _$StoryItemModel];
  @override
  final String wireName = 'StoryItemModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    StoryItemModel object, {
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
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isActive;
    if (value != null) {
      result
        ..add('is_active')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.protect;
    if (value != null) {
      result
        ..add('protect')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mediaType;
    if (value != null) {
      result
        ..add('media_type')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  StoryItemModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new StoryItemModelBuilder();

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
        case 'image':
          result.image =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'is_active':
          result.isActive =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'protect':
          result.protect =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'media_type':
          result.mediaType =
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

class _$FilterResSerializer implements StructuredSerializer<FilterRes> {
  @override
  final Iterable<Type> types = const [FilterRes, _$FilterRes];
  @override
  final String wireName = 'FilterRes';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    FilterRes object, {
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
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  FilterRes deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new FilterResBuilder();

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
        case 'image':
          result.image =
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

class _$FilterItemModelSerializer
    implements StructuredSerializer<FilterItemModel> {
  @override
  final Iterable<Type> types = const [FilterItemModel, _$FilterItemModel];
  @override
  final String wireName = 'FilterItemModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    FilterItemModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.brandId;
    if (value != null) {
      result
        ..add('brand_id')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.countryId;
    if (value != null) {
      result
        ..add('country_id')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.setId;
    if (value != null) {
      result
        ..add('set_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.categoryId;
    if (value != null) {
      result
        ..add('category_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  FilterItemModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new FilterItemModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'brand_id':
          result.brandId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'country_id':
          result.countryId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'set_id':
          result.setId =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'category_id':
          result.categoryId =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$SearchModelSerializer implements StructuredSerializer<SearchModel> {
  @override
  final Iterable<Type> types = const [SearchModel, _$SearchModel];
  @override
  final String wireName = 'SearchModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SearchModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.brandData;
    if (value != null) {
      result
        ..add('brand_data')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(BrandData),
            ]),
          ),
        );
    }
    value = object.categories;
    if (value != null) {
      result
        ..add('categories')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(Categories),
            ]),
          ),
        );
    }
    value = object.countries;
    if (value != null) {
      result
        ..add('countries')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(BrandData),
            ]),
          ),
        );
    }
    value = object.products;
    if (value != null) {
      result
        ..add('products')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(ProductModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  SearchModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SearchModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'brand_data':
          result.brandData.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(BrandData),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'categories':
          result.categories.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(Categories),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'countries':
          result.countries.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(BrandData),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'products':
          result.products.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(ProductModel),
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

class _$BrandDataSerializer implements StructuredSerializer<BrandData> {
  @override
  final Iterable<Type> types = const [BrandData, _$BrandData];
  @override
  final String wireName = 'BrandData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    BrandData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
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
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  BrandData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new BrandDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
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
        case 'image':
          result.image =
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

class _$BannerModel extends BannerModel {
  @override
  final int? id;
  @override
  final int? brand;
  @override
  final String? image;
  @override
  final int? priority;

  factory _$BannerModel([void Function(BannerModelBuilder)? updates]) =>
      (new BannerModelBuilder()..update(updates))._build();

  _$BannerModel._({this.id, this.brand, this.image, this.priority}) : super._();

  @override
  BannerModel rebuild(void Function(BannerModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BannerModelBuilder toBuilder() => new BannerModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BannerModel &&
        id == other.id &&
        brand == other.brand &&
        image == other.image &&
        priority == other.priority;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BannerModel')
          ..add('id', id)
          ..add('brand', brand)
          ..add('image', image)
          ..add('priority', priority))
        .toString();
  }
}

class BannerModelBuilder implements Builder<BannerModel, BannerModelBuilder> {
  _$BannerModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _brand;
  int? get brand => _$this._brand;
  set brand(int? brand) => _$this._brand = brand;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  int? _priority;
  int? get priority => _$this._priority;
  set priority(int? priority) => _$this._priority = priority;

  BannerModelBuilder();

  BannerModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _brand = $v.brand;
      _image = $v.image;
      _priority = $v.priority;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BannerModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BannerModel;
  }

  @override
  void update(void Function(BannerModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BannerModel build() => _build();

  _$BannerModel _build() {
    final _$result =
        _$v ??
        new _$BannerModel._(
          id: id,
          brand: brand,
          image: image,
          priority: priority,
        );
    replace(_$result);
    return _$result;
  }
}

class _$SetModel extends SetModel {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final String? icon;
  @override
  final int? priority;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  factory _$SetModel([void Function(SetModelBuilder)? updates]) =>
      (new SetModelBuilder()..update(updates))._build();

  _$SetModel._({
    this.id,
    this.name,
    this.description,
    this.image,
    this.icon,
    this.priority,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  @override
  SetModel rebuild(void Function(SetModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetModelBuilder toBuilder() => new SetModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetModel &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        image == other.image &&
        icon == other.icon &&
        priority == other.priority &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetModel')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('image', image)
          ..add('icon', icon)
          ..add('priority', priority)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SetModelBuilder implements Builder<SetModel, SetModelBuilder> {
  _$SetModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  int? _priority;
  int? get priority => _$this._priority;
  set priority(int? priority) => _$this._priority = priority;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  SetModelBuilder();

  SetModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _image = $v.image;
      _icon = $v.icon;
      _priority = $v.priority;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SetModel;
  }

  @override
  void update(void Function(SetModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetModel build() => _build();

  _$SetModel _build() {
    final _$result =
        _$v ??
        new _$SetModel._(
          id: id,
          name: name,
          description: description,
          image: image,
          icon: icon,
          priority: priority,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

class _$StoryModel extends StoryModel {
  @override
  final int? id;
  @override
  final int? count;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final BuiltList<StoryItemModel>? stories;

  factory _$StoryModel([void Function(StoryModelBuilder)? updates]) =>
      (new StoryModelBuilder()..update(updates))._build();

  _$StoryModel._({
    this.id,
    this.count,
    this.title,
    this.description,
    this.image,
    this.stories,
  }) : super._();

  @override
  StoryModel rebuild(void Function(StoryModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryModelBuilder toBuilder() => new StoryModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryModel &&
        id == other.id &&
        count == other.count &&
        title == other.title &&
        description == other.description &&
        image == other.image &&
        stories == other.stories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, stories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StoryModel')
          ..add('id', id)
          ..add('count', count)
          ..add('title', title)
          ..add('description', description)
          ..add('image', image)
          ..add('stories', stories))
        .toString();
  }
}

class StoryModelBuilder implements Builder<StoryModel, StoryModelBuilder> {
  _$StoryModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  ListBuilder<StoryItemModel>? _stories;
  ListBuilder<StoryItemModel> get stories =>
      _$this._stories ??= new ListBuilder<StoryItemModel>();
  set stories(ListBuilder<StoryItemModel>? stories) =>
      _$this._stories = stories;

  StoryModelBuilder();

  StoryModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _count = $v.count;
      _title = $v.title;
      _description = $v.description;
      _image = $v.image;
      _stories = $v.stories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StoryModel;
  }

  @override
  void update(void Function(StoryModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StoryModel build() => _build();

  _$StoryModel _build() {
    _$StoryModel _$result;
    try {
      _$result =
          _$v ??
          new _$StoryModel._(
            id: id,
            count: count,
            title: title,
            description: description,
            image: image,
            stories: _stories?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'stories';
        _stories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'StoryModel',
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

class _$StoryItemModel extends StoryItemModel {
  @override
  final int? id;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final bool? isActive;
  @override
  final int? protect;
  @override
  final String? mediaType;

  factory _$StoryItemModel([void Function(StoryItemModelBuilder)? updates]) =>
      (new StoryItemModelBuilder()..update(updates))._build();

  _$StoryItemModel._({
    this.id,
    this.image,
    this.description,
    this.isActive,
    this.protect,
    this.mediaType,
  }) : super._();

  @override
  StoryItemModel rebuild(void Function(StoryItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryItemModelBuilder toBuilder() =>
      new StoryItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryItemModel &&
        id == other.id &&
        image == other.image &&
        description == other.description &&
        isActive == other.isActive &&
        protect == other.protect &&
        mediaType == other.mediaType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, protect.hashCode);
    _$hash = $jc(_$hash, mediaType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StoryItemModel')
          ..add('id', id)
          ..add('image', image)
          ..add('description', description)
          ..add('isActive', isActive)
          ..add('protect', protect)
          ..add('mediaType', mediaType))
        .toString();
  }
}

class StoryItemModelBuilder
    implements Builder<StoryItemModel, StoryItemModelBuilder> {
  _$StoryItemModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  int? _protect;
  int? get protect => _$this._protect;
  set protect(int? protect) => _$this._protect = protect;

  String? _mediaType;
  String? get mediaType => _$this._mediaType;
  set mediaType(String? mediaType) => _$this._mediaType = mediaType;

  StoryItemModelBuilder();

  StoryItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _image = $v.image;
      _description = $v.description;
      _isActive = $v.isActive;
      _protect = $v.protect;
      _mediaType = $v.mediaType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StoryItemModel;
  }

  @override
  void update(void Function(StoryItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StoryItemModel build() => _build();

  _$StoryItemModel _build() {
    final _$result =
        _$v ??
        new _$StoryItemModel._(
          id: id,
          image: image,
          description: description,
          isActive: isActive,
          protect: protect,
          mediaType: mediaType,
        );
    replace(_$result);
    return _$result;
  }
}

class _$FilterRes extends FilterRes {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? image;

  factory _$FilterRes([void Function(FilterResBuilder)? updates]) =>
      (new FilterResBuilder()..update(updates))._build();

  _$FilterRes._({this.id, this.title, this.image}) : super._();

  @override
  FilterRes rebuild(void Function(FilterResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FilterResBuilder toBuilder() => new FilterResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FilterRes &&
        id == other.id &&
        title == other.title &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FilterRes')
          ..add('id', id)
          ..add('title', title)
          ..add('image', image))
        .toString();
  }
}

class FilterResBuilder implements Builder<FilterRes, FilterResBuilder> {
  _$FilterRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  FilterResBuilder();

  FilterResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FilterRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FilterRes;
  }

  @override
  void update(void Function(FilterResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FilterRes build() => _build();

  _$FilterRes _build() {
    final _$result =
        _$v ?? new _$FilterRes._(id: id, title: title, image: image);
    replace(_$result);
    return _$result;
  }
}

class _$FilterItemModel extends FilterItemModel {
  @override
  final String? brandId;
  @override
  final String? countryId;
  @override
  final int? setId;
  @override
  final int? categoryId;

  factory _$FilterItemModel([void Function(FilterItemModelBuilder)? updates]) =>
      (new FilterItemModelBuilder()..update(updates))._build();

  _$FilterItemModel._({
    this.brandId,
    this.countryId,
    this.setId,
    this.categoryId,
  }) : super._();

  @override
  FilterItemModel rebuild(void Function(FilterItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FilterItemModelBuilder toBuilder() =>
      new FilterItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FilterItemModel &&
        brandId == other.brandId &&
        countryId == other.countryId &&
        setId == other.setId &&
        categoryId == other.categoryId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, brandId.hashCode);
    _$hash = $jc(_$hash, countryId.hashCode);
    _$hash = $jc(_$hash, setId.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FilterItemModel')
          ..add('brandId', brandId)
          ..add('countryId', countryId)
          ..add('setId', setId)
          ..add('categoryId', categoryId))
        .toString();
  }
}

class FilterItemModelBuilder
    implements Builder<FilterItemModel, FilterItemModelBuilder> {
  _$FilterItemModel? _$v;

  String? _brandId;
  String? get brandId => _$this._brandId;
  set brandId(String? brandId) => _$this._brandId = brandId;

  String? _countryId;
  String? get countryId => _$this._countryId;
  set countryId(String? countryId) => _$this._countryId = countryId;

  int? _setId;
  int? get setId => _$this._setId;
  set setId(int? setId) => _$this._setId = setId;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  FilterItemModelBuilder();

  FilterItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _brandId = $v.brandId;
      _countryId = $v.countryId;
      _setId = $v.setId;
      _categoryId = $v.categoryId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FilterItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FilterItemModel;
  }

  @override
  void update(void Function(FilterItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FilterItemModel build() => _build();

  _$FilterItemModel _build() {
    final _$result =
        _$v ??
        new _$FilterItemModel._(
          brandId: brandId,
          countryId: countryId,
          setId: setId,
          categoryId: categoryId,
        );
    replace(_$result);
    return _$result;
  }
}

class _$SearchModel extends SearchModel {
  @override
  final BuiltList<BrandData>? brandData;
  @override
  final BuiltList<Categories>? categories;
  @override
  final BuiltList<BrandData>? countries;
  @override
  final BuiltList<ProductModel>? products;

  factory _$SearchModel([void Function(SearchModelBuilder)? updates]) =>
      (new SearchModelBuilder()..update(updates))._build();

  _$SearchModel._({
    this.brandData,
    this.categories,
    this.countries,
    this.products,
  }) : super._();

  @override
  SearchModel rebuild(void Function(SearchModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchModelBuilder toBuilder() => new SearchModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchModel &&
        brandData == other.brandData &&
        categories == other.categories &&
        countries == other.countries &&
        products == other.products;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, brandData.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, countries.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchModel')
          ..add('brandData', brandData)
          ..add('categories', categories)
          ..add('countries', countries)
          ..add('products', products))
        .toString();
  }
}

class SearchModelBuilder implements Builder<SearchModel, SearchModelBuilder> {
  _$SearchModel? _$v;

  ListBuilder<BrandData>? _brandData;
  ListBuilder<BrandData> get brandData =>
      _$this._brandData ??= new ListBuilder<BrandData>();
  set brandData(ListBuilder<BrandData>? brandData) =>
      _$this._brandData = brandData;

  ListBuilder<Categories>? _categories;
  ListBuilder<Categories> get categories =>
      _$this._categories ??= new ListBuilder<Categories>();
  set categories(ListBuilder<Categories>? categories) =>
      _$this._categories = categories;

  ListBuilder<BrandData>? _countries;
  ListBuilder<BrandData> get countries =>
      _$this._countries ??= new ListBuilder<BrandData>();
  set countries(ListBuilder<BrandData>? countries) =>
      _$this._countries = countries;

  ListBuilder<ProductModel>? _products;
  ListBuilder<ProductModel> get products =>
      _$this._products ??= new ListBuilder<ProductModel>();
  set products(ListBuilder<ProductModel>? products) =>
      _$this._products = products;

  SearchModelBuilder();

  SearchModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _brandData = $v.brandData?.toBuilder();
      _categories = $v.categories?.toBuilder();
      _countries = $v.countries?.toBuilder();
      _products = $v.products?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchModel;
  }

  @override
  void update(void Function(SearchModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchModel build() => _build();

  _$SearchModel _build() {
    _$SearchModel _$result;
    try {
      _$result =
          _$v ??
          new _$SearchModel._(
            brandData: _brandData?.build(),
            categories: _categories?.build(),
            countries: _countries?.build(),
            products: _products?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'brandData';
        _brandData?.build();
        _$failedField = 'categories';
        _categories?.build();
        _$failedField = 'countries';
        _countries?.build();
        _$failedField = 'products';
        _products?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'SearchModel',
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

class _$BrandData extends BrandData {
  @override
  final String? name;
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? image;

  factory _$BrandData([void Function(BrandDataBuilder)? updates]) =>
      (new BrandDataBuilder()..update(updates))._build();

  _$BrandData._({this.name, this.id, this.title, this.image}) : super._();

  @override
  BrandData rebuild(void Function(BrandDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandDataBuilder toBuilder() => new BrandDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BrandData &&
        name == other.name &&
        id == other.id &&
        title == other.title &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BrandData')
          ..add('name', name)
          ..add('id', id)
          ..add('title', title)
          ..add('image', image))
        .toString();
  }
}

class BrandDataBuilder implements Builder<BrandData, BrandDataBuilder> {
  _$BrandData? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  BrandDataBuilder();

  BrandDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _title = $v.title;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BrandData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BrandData;
  }

  @override
  void update(void Function(BrandDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BrandData build() => _build();

  _$BrandData _build() {
    final _$result =
        _$v ??
        new _$BrandData._(name: name, id: id, title: title, image: image);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
