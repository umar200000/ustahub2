import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ustahub/domain/models/product/product_model.dart';

part 'home_model.g.dart';

abstract class BannerModel implements Built<BannerModel, BannerModelBuilder> {
  BannerModel._();

  factory BannerModel([Function(BannerModelBuilder b) updates]) = _$BannerModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'brand')
  int? get brand;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'priority')
  int? get priority;

  static Serializer<BannerModel> get serializer => _$bannerModelSerializer;
}

abstract class SetModel implements Built<SetModel, SetModelBuilder> {
  SetModel._();

  factory SetModel([Function(SetModelBuilder b) updates]) = _$SetModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'icon')
  String? get icon;
  @BuiltValueField(wireName: 'priority')
  int? get priority;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'updated_at')
  String? get updatedAt;

  static Serializer<SetModel> get serializer => _$setModelSerializer;
}

abstract class StoryModel implements Built<StoryModel, StoryModelBuilder> {
  StoryModel._();

  factory StoryModel([Function(StoryModelBuilder b) updates]) = _$StoryModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'count')
  int? get count;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'stories')
  BuiltList<StoryItemModel>? get stories;

  static Serializer<StoryModel> get serializer => _$storyModelSerializer;
}

abstract class StoryItemModel
    implements Built<StoryItemModel, StoryItemModelBuilder> {
  StoryItemModel._();

  factory StoryItemModel([Function(StoryItemModelBuilder b) updates]) =
      _$StoryItemModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'is_active')
  bool? get isActive;
  @BuiltValueField(wireName: 'protect')
  int? get protect;
  @BuiltValueField(wireName: 'media_type')
  String? get mediaType;

  static Serializer<StoryItemModel> get serializer =>
      _$storyItemModelSerializer;
}

abstract class FilterRes implements Built<FilterRes, FilterResBuilder> {
  FilterRes._();

  factory FilterRes([Function(FilterResBuilder b) updates]) = _$FilterRes;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'image')
  String? get image;

  static Serializer<FilterRes> get serializer => _$filterResSerializer;
}

abstract class FilterItemModel
    implements Built<FilterItemModel, FilterItemModelBuilder> {
  FilterItemModel._();

  factory FilterItemModel([Function(FilterItemModelBuilder b) updates]) =
      _$FilterItemModel;

  @BuiltValueField(wireName: 'brand_id')
  String? get brandId;
  @BuiltValueField(wireName: 'country_id')
  String? get countryId;
  @BuiltValueField(wireName: 'set_id')
  int? get setId;
  @BuiltValueField(wireName: 'category_id')
  int? get categoryId;

  static Serializer<FilterItemModel> get serializer =>
      _$filterItemModelSerializer;
}

abstract class SearchModel implements Built<SearchModel, SearchModelBuilder> {
  SearchModel._();

  factory SearchModel([Function(SearchModelBuilder b) updates]) = _$SearchModel;

  @BuiltValueField(wireName: 'brand_data')
  BuiltList<BrandData>? get brandData;
  @BuiltValueField(wireName: 'categories')
  BuiltList<Categories>? get categories;
  @BuiltValueField(wireName: 'countries')
  BuiltList<BrandData>? get countries;
  @BuiltValueField(wireName: 'products')
  BuiltList<ProductModel>? get products;

  static Serializer<SearchModel> get serializer => _$searchModelSerializer;
}

abstract class BrandData implements Built<BrandData, BrandDataBuilder> {
  BrandData._();

  factory BrandData([Function(BrandDataBuilder b) updates]) = _$BrandData;

  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'image')
  String? get image;

  static Serializer<BrandData> get serializer => _$brandDataSerializer;
}
