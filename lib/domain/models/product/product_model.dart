import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ustahub/domain/models/home/home_model.dart';

part 'product_model.g.dart';

abstract class Catalog implements Built<Catalog, CatalogBuilder> {
  Catalog._();

  factory Catalog([Function(CatalogBuilder b) updates]) = _$Catalog;

  @BuiltValueField(wireName: 'data')
  BuiltList<SubCategoryModel>? get data;
  @BuiltValueField(wireName: 'current_page')
  int? get currentPage;
  @BuiltValueField(wireName: 'total_pages')
  int? get totalPages;
  @BuiltValueField(wireName: 'has_next')
  bool? get hasNext;
  @BuiltValueField(wireName: 'has_previous')
  bool? get hasPrevious;

  static Serializer<Catalog> get serializer => _$catalogSerializer;
}

abstract class SubCategoryModel
    implements Built<SubCategoryModel, SubCategoryModelBuilder> {
  SubCategoryModel._();

  factory SubCategoryModel([void Function(SubCategoryModelBuilder) updates]) =
      _$SubCategoryModel;

  @BuiltValueField(wireName: 'sub_category_title')
  String? get subCategoryTitle;
  @BuiltValueField(wireName: 'items')
  BuiltList<ItemModel>? get items;
  @BuiltValueField(wireName: 'parents')
  BuiltList<StoryModel>? get parents;
  @BuiltValueField(wireName: 'children')
  BuiltList<StoryModel>? get children;

  static Serializer<SubCategoryModel> get serializer =>
      _$subCategoryModelSerializer;
}

abstract class ItemModel implements Built<ItemModel, ItemModelBuilder> {
  ItemModel._();

  factory ItemModel([void Function(ItemModelBuilder) updates]) = _$ItemModel;

  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'background_image')
  String? get backgroundImage;
  @BuiltValueField(wireName: 'flag')
  String? get flag;
  @BuiltValueField(wireName: 'families')
  BuiltList<FamilyModel>? get families;

  static Serializer<ItemModel> get serializer => _$itemModelSerializer;
}

abstract class FamilyModel implements Built<FamilyModel, FamilyModelBuilder> {
  FamilyModel._();

  factory FamilyModel([void Function(FamilyModelBuilder) updates]) =
      _$FamilyModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'products')
  BuiltList<ProductModel>? get products;
  @BuiltValueField(wireName: 'product_count')
  int? get productCount;

  static Serializer<FamilyModel> get serializer => _$familyModelSerializer;
}

abstract class CategoryListModel
    implements Built<CategoryListModel, CategoryListModelBuilder> {
  CategoryListModel._();

  factory CategoryListModel([Function(CategoryListModelBuilder b) updates]) =
      _$CategoryListModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'categories')
  BuiltList<BuiltList<ProductModel>>? get categories;

  static Serializer<CategoryListModel> get serializer =>
      _$categoryListModelSerializer;
}

abstract class ProductModel
    implements Built<ProductModel, ProductModelBuilder> {
  ProductModel._();

  factory ProductModel([void Function(ProductModelBuilder) updates]) =
      _$ProductModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'product')
  int? get product;
  @BuiltValueField(wireName: 'count')
  int? get count;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'short_name')
  String? get shortName;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'image_grid')
  String? get imageGrid;
  @BuiltValueField(wireName: 'picture')
  String? get picture;
  @BuiltValueField(wireName: 'flag')
  String? get flag;
  @BuiltValueField(wireName: 'volume')
  double? get volume;
  @BuiltValueField(wireName: 'previous_price')
  double? get previousPrice;
  @BuiltValueField(wireName: 'volume_unit')
  String? get volumeUnit;
  @BuiltValueField(wireName: 'available_quantity')
  int? get availableQuantity;
  @BuiltValueField(wireName: 'price')
  double? get price;
  @BuiltValueField(wireName: 'date')
  String? get date;
  @BuiltValueField(wireName: 'time')
  String? get time;
  @BuiltValueField(wireName: 'is_new')
  bool? get isNew;
  @BuiltValueField(wireName: 'is_popular')
  bool? get isPopular;
  @BuiltValueField(wireName: 'is_auto_added')
  bool? get isAutoAdded;
  @BuiltValueField(wireName: 'product_count')
  int? get productCount;

  static Serializer<ProductModel> get serializer => _$productModelSerializer;
}

abstract class ModifiedModel
    implements Built<ModifiedModel, ModifiedModelBuilder> {
  ModifiedModel._();

  factory ModifiedModel([Function(ModifiedModelBuilder b) updates]) =
      _$ModifiedModel;

  @BuiltValueField(wireName: 'product')
  ProductModel? get product;
  @BuiltValueField(wireName: 'requested')
  int? get requested;
  @BuiltValueField(wireName: 'available')
  int? get available;

  static Serializer<ModifiedModel> get serializer => _$modifiedModelSerializer;
}

abstract class InformModel implements Built<InformModel, InformModelBuilder> {
  InformModel._();

  @BuiltValueField(wireName: 'product')
  int? get product;

  @BuiltValueField(wireName: 'count')
  int? get count;

  factory InformModel([Function(InformModelBuilder b) updates]) = _$InformModel;

  static Serializer<InformModel> get serializer => _$informModelSerializer;
}

abstract class OrderModel implements Built<OrderModel, OrderModelBuilder> {
  OrderModel._();

  factory OrderModel([Function(OrderModelBuilder b) updates]) = _$OrderModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'order_id')
  int? get orderId;
  @BuiltValueField(wireName: 'client')
  String? get client;
  @BuiltValueField(wireName: 'check_number')
  String? get checkNumber;
  @BuiltValueField(wireName: 'phone')
  String? get phone;
  @BuiltValueField(wireName: 'address')
  String? get address;
  @BuiltValueField(wireName: 'address_name')
  String? get addressName;
  @BuiltValueField(wireName: 'payment')
  String? get payment;
  @BuiltValueField(wireName: 'actual_order_create_time')
  String? get actualOrderCreateTime;
  @BuiltValueField(wireName: 'delivery_time')
  String? get deliveryTime;
  @BuiltValueField(wireName: 'accepted_at')
  String? get acceptedAt;
  @BuiltValueField(wireName: 'collected_at')
  String? get collectedAt;
  @BuiltValueField(wireName: 'delivered_at')
  String? get deliveredAt;
  @BuiltValueField(wireName: 'delivery_started_at')
  String? get deliveryStartedAt;
  @BuiltValueField(wireName: 'status')
  String? get status;
  @BuiltValueField(wireName: 'total_amount')
  double? get totalAmount;
  @BuiltValueField(wireName: 'items_count')
  int? get itemsCount;
  @BuiltValueField(wireName: 'amount_to_pay')
  double? get amountToPay;
  @BuiltValueField(wireName: 'delivery_price')
  double? get deliveryPrice;
  @BuiltValueField(wireName: 'service_price')
  double? get servicePrice;
  @BuiltValueField(wireName: 'promocode_price')
  double? get promocodePrice;
  @BuiltValueField(wireName: 'fiscal_check')
  String? get fiscalCheck;
  @BuiltValueField(wireName: 'is_first_order')
  bool? get isFirstOrder;
  @BuiltValueField(wireName: 'order_throught')
  BuiltList<ProductModel>? get orderThrought;
  @BuiltValueField(wireName: 'order_items_images')
  BuiltList<String>? get orderItemsImages;

  static Serializer<OrderModel> get serializer => _$orderModelSerializer;
}

abstract class OrderReq implements Built<OrderReq, OrderReqBuilder> {
  OrderReq._();

  factory OrderReq([Function(OrderReqBuilder b) updates]) = _$OrderReq;
  @BuiltValueField(wireName: 'code')
  String? get code;
  @BuiltValueField(wireName: 'total_amount')
  double? get totalAmount;
  @BuiltValueField(wireName: 'status')
  String? get status;
  @BuiltValueField(wireName: 'products')
  BuiltList<ProductModel>? get products;
  @BuiltValueField(wireName: 'comment')
  String? get comment;
  @BuiltValueField(wireName: 'amount_to_pay')
  double? get amountToPay;
  @BuiltValueField(wireName: 'delivery_price')
  double? get deliveryPrice;
  @BuiltValueField(wireName: 'expres_price')
  double? get expresPrice;
  @BuiltValueField(wireName: 'service_price')
  double? get servicePrice;
  @BuiltValueField(wireName: 'minimum_price')
  double? get minimumPrice;
  @BuiltValueField(wireName: 'from_balance')
  double? get fromBalance;
  @BuiltValueField(wireName: 'tips_price')
  double? get tipsPrice;

  @BuiltValueField(wireName: 'estimated_order_time')
  String? get estimatedOrderTime;
  @BuiltValueField(wireName: 'payment')
  int? get payment;
  @BuiltValueField(wireName: 'address')
  int? get address;
  @BuiltValueField(wireName: 'promo')
  int? get promo;
  @BuiltValueField(wireName: 'is_additional')
  bool? get isAdditional;
  @BuiltValueField(wireName: 'order_to_add')
  int? get orderToAdd;
  @BuiltValueField(wireName: 'category')
  int? get category;

  static Serializer<OrderReq> get serializer => _$orderReqSerializer;
}

abstract class Categories implements Built<Categories, CategoriesBuilder> {
  Categories._();

  factory Categories([Function(CategoriesBuilder b) updates]) = _$Categories;

  @BuiltValueField(wireName: 'category_name')
  String? get categoryName;
  @BuiltValueField(wireName: 'icon')
  String? get icon;
  @BuiltValueField(wireName: 'sub_categories')
  BuiltList<SubCategories>? get subCategories;

  static Serializer<Categories> get serializer => _$categoriesSerializer;
}

abstract class SubCategories
    implements Built<SubCategories, SubCategoriesBuilder> {
  SubCategories._();

  factory SubCategories([Function(SubCategoriesBuilder b) updates]) =
      _$SubCategories;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'name')
  String? get name;
  @BuiltValueField(wireName: 'image')
  String? get image;

  static Serializer<SubCategories> get serializer => _$subCategoriesSerializer;
}

abstract class OrderStatusRes
    implements Built<OrderStatusRes, OrderStatusResBuilder> {
  OrderStatusRes._();

  factory OrderStatusRes([Function(OrderStatusResBuilder b) updates]) =
      _$OrderStatusRes;

  @BuiltValueField(wireName: 'status')
  String? get status;
  @BuiltValueField(wireName: 'address')
  String? get address;
  @BuiltValueField(wireName: 'check_number')
  String? get checkNumber;
  @BuiltValueField(wireName: 'actual_order_create_time')
  String? get actualOrderCreateTime;
  @BuiltValueField(wireName: 'delivery_time')
  String? get deliveryTime;
  @BuiltValueField(wireName: 'delivery_started_at')
  String? get deliveryStartedAt;
  @BuiltValueField(wireName: 'delivered_at')
  String? get deliveredAt;
  @BuiltValueField(wireName: 'collected_at')
  String? get collectedAt;
  @BuiltValueField(wireName: 'accepted_at')
  String? get acceptedAt;
  static Serializer<OrderStatusRes> get serializer =>
      _$orderStatusResSerializer;
}

abstract class PlannedOrderListModel
    implements Built<PlannedOrderListModel, PlannedOrderListModelBuilder> {
  PlannedOrderListModel._();

  @BuiltValueField(wireName: 'page')
  int? get page;
  @BuiltValueField(wireName: 'count')
  int? get count;
  @BuiltValueField(wireName: 'total_pages')
  int? get totalPages;
  @BuiltValueField(wireName: 'results')
  BuiltList<PlannedOrderModel>? get results;

  factory PlannedOrderListModel([
    Function(PlannedOrderListModelBuilder b) updates,
  ]) = _$PlannedOrderListModel;

  static Serializer<PlannedOrderListModel> get serializer =>
      _$plannedOrderListModelSerializer;
}

abstract class PlannedOrderModel
    implements Built<PlannedOrderModel, PlannedOrderModelBuilder> {
  PlannedOrderModel._();

  factory PlannedOrderModel([Function(PlannedOrderModelBuilder b) updates]) =
      _$PlannedOrderModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'items')
  BuiltList<ProductModel>? get items;
  @BuiltValueField(wireName: 'schedules')
  BuiltList<Schedules>? get schedules;
  @BuiltValueField(wireName: 'address_name')
  String? get addressName;
  @BuiltValueField(wireName: 'address_title')
  String? get addressTitle;
  @BuiltValueField(wireName: 'payment_name')
  String? get paymentName;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'status')
  String? get status;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'updated_at')
  String? get updatedAt;
  @BuiltValueField(wireName: 'client')
  int? get client;
  @BuiltValueField(wireName: 'payment_type')
  int? get paymentType;
  @BuiltValueField(wireName: 'address')
  int? get address;
  @BuiltValueField(wireName: 'total_amount')
  double? get totalAmountValue;
  @BuiltValueField(wireName: 'items_count')
  int? get itemsCount;
  @BuiltValueField(wireName: 'time')
  String? get time;
  @BuiltValueField(wireName: 'day_of_weeks')
  String? get dayOfWeeks;
  @BuiltValueField(wireName: 'images')
  BuiltList<String>? get images;
  @BuiltValueField(wireName: 'weeks')
  BuiltList<DayModel>? get weeks;

  static Serializer<PlannedOrderModel> get serializer =>
      _$plannedOrderModelSerializer;
}

abstract class DayModel implements Built<DayModel, DayModelBuilder> {
  DayModel._();

  factory DayModel([Function(DayModelBuilder b) updates]) = _$DayModel;

  @BuiltValueField(wireName: 'day')
  String? get day;

  @BuiltValueField(wireName: 'is_active')
  bool? get isActive;

  static Serializer<DayModel> get serializer => _$dayModelSerializer;
}

abstract class Schedules implements Built<Schedules, SchedulesBuilder> {
  Schedules._();

  factory Schedules([Function(SchedulesBuilder b) updates]) = _$Schedules;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'day_of_week')
  int? get dayOfWeek;
  @BuiltValueField(wireName: 'time')
  String? get time;
  @BuiltValueField(wireName: 'is_active')
  bool? get isActive;

  static Serializer<Schedules> get serializer => _$schedulesSerializer;
}

abstract class InformRes implements Built<InformRes, InformResBuilder> {
  InformRes._();

  factory InformRes([Function(InformResBuilder b) updates]) = _$InformRes;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'product')
  ProductModel? get product;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'is_sent')
  bool? get isSent;

  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  String? get updatedAt;

  static Serializer<InformRes> get serializer => _$informResSerializer;
}

abstract class Inform implements Built<Inform, InformBuilder> {
  Inform._();

  factory Inform([Function(InformBuilder b) updates]) = _$Inform;

  @BuiltValueField(wireName: 'page')
  int? get page;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'total_pages')
  int? get totalPages;

  @BuiltValueField(wireName: 'results')
  BuiltList<InformRes>? get results;

  static Serializer<Inform> get serializer => _$informSerializer;
}

abstract class InformCreateRes
    implements Built<InformCreateRes, InformCreateResBuilder> {
  InformCreateRes._();

  factory InformCreateRes([Function(InformCreateResBuilder b) updates]) =
      _$InformCreateRes;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'product')
  int? get product;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'is_sent')
  bool? get isSent;

  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  String? get updatedAt;

  @BuiltValueField(wireName: 'client')
  int? get client;

  static Serializer<InformCreateRes> get serializer =>
      _$informCreateResSerializer;
}

abstract class ProductCatalogResponse
    implements Built<ProductCatalogResponse, ProductCatalogResponseBuilder> {
  ProductCatalogResponse._();

  factory ProductCatalogResponse([
    Function(ProductCatalogResponseBuilder b) updates,
  ]) = _$ProductCatalogResponse;

  @BuiltValueField(wireName: 'count')
  int? get count;

  @BuiltValueField(wireName: 'next')
  bool? get next;

  @BuiltValueField(wireName: 'previous')
  bool? get previous;

  @BuiltValueField(wireName: 'results')
  BuiltList<ProductCategory>? get results;

  static Serializer<ProductCatalogResponse> get serializer =>
      _$productCatalogResponseSerializer;
}

abstract class ProductModelResponse
    implements Built<ProductModelResponse, ProductModelResponseBuilder> {
  ProductModelResponse._();

  factory ProductModelResponse([
    Function(ProductModelResponseBuilder b) updates,
  ]) = _$ProductModelResponse;

  @BuiltValueField(wireName: 'page')
  int? get page;
  @BuiltValueField(wireName: 'count')
  int? get count;
  @BuiltValueField(wireName: 'total_pages')
  int? get totalPages;
  @BuiltValueField(wireName: 'results')
  BuiltList<ProductModel>? get results;

  static Serializer<ProductModelResponse> get serializer =>
      _$productModelResponseSerializer;
}

abstract class ProductCategory
    implements Built<ProductCategory, ProductCategoryBuilder> {
  ProductCategory._();

  factory ProductCategory([Function(ProductCategoryBuilder b) updates]) =
      _$ProductCategory;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'image')
  String? get image;

  @BuiltValueField(wireName: 'category')
  int? get category;

  @BuiltValueField(wireName: 'products')
  BuiltList<ProductModel>? get products;

  @BuiltValueField(wireName: 'product_count')
  int? get productCount;

  static Serializer<ProductCategory> get serializer =>
      _$productCategorySerializer;
}

abstract class ProductDetailModel
    implements Built<ProductDetailModel, ProductDetailModelBuilder> {
  ProductDetailModel._();

  factory ProductDetailModel([Function(ProductDetailModelBuilder b) updates]) =
      _$ProductDetailModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'image')
  String? get image;

  @BuiltValueField(wireName: 'flag')
  String? get flag;

  @BuiltValueField(wireName: 'expire_date')
  int? get expireDate;

  @BuiltValueField(wireName: 'is_new')
  bool? get isNew;

  @BuiltValueField(wireName: 'is_popular')
  bool? get isPopular;

  @BuiltValueField(wireName: 'description')
  String? get description;

  @BuiltValueField(wireName: 'nutrition')
  NutritionModel? get nutrition;

  static Serializer<ProductDetailModel> get serializer =>
      _$productDetailModelSerializer;
}

abstract class NutritionModel
    implements Built<NutritionModel, NutritionModelBuilder> {
  NutritionModel._();

  factory NutritionModel([Function(NutritionModelBuilder b) updates]) =
      _$NutritionModel;

  @BuiltValueField(wireName: 'proteins')
  double? get proteins;

  @BuiltValueField(wireName: 'fats')
  double? get fats;

  @BuiltValueField(wireName: 'carbohydrates')
  double? get carbohydrates;

  @BuiltValueField(wireName: 'calories')
  double? get calories;

  static Serializer<NutritionModel> get serializer =>
      _$nutritionModelSerializer;
}

abstract class SectionModel
    implements Built<SectionModel, SectionModelBuilder> {
  SectionModel._();

  factory SectionModel([Function(SectionModelBuilder b) updates]) =
      _$SectionModel;

  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'image')
  String? get image;

  @BuiltValueField(wireName: 'priority')
  int? get priority;

  @BuiltValueField(wireName: 'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: 'categories')
  BuiltList<ProductModel>? get categories;

  static Serializer<SectionModel> get serializer => _$sectionModelSerializer;
}
