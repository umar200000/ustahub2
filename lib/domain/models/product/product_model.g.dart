// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Catalog> _$catalogSerializer = new _$CatalogSerializer();
Serializer<SubCategoryModel> _$subCategoryModelSerializer =
    new _$SubCategoryModelSerializer();
Serializer<ItemModel> _$itemModelSerializer = new _$ItemModelSerializer();
Serializer<FamilyModel> _$familyModelSerializer = new _$FamilyModelSerializer();
Serializer<CategoryListModel> _$categoryListModelSerializer =
    new _$CategoryListModelSerializer();
Serializer<ProductModel> _$productModelSerializer =
    new _$ProductModelSerializer();
Serializer<ModifiedModel> _$modifiedModelSerializer =
    new _$ModifiedModelSerializer();
Serializer<InformModel> _$informModelSerializer = new _$InformModelSerializer();
Serializer<OrderModel> _$orderModelSerializer = new _$OrderModelSerializer();
Serializer<OrderReq> _$orderReqSerializer = new _$OrderReqSerializer();
Serializer<Categories> _$categoriesSerializer = new _$CategoriesSerializer();
Serializer<SubCategories> _$subCategoriesSerializer =
    new _$SubCategoriesSerializer();
Serializer<OrderStatusRes> _$orderStatusResSerializer =
    new _$OrderStatusResSerializer();
Serializer<PlannedOrderListModel> _$plannedOrderListModelSerializer =
    new _$PlannedOrderListModelSerializer();
Serializer<PlannedOrderModel> _$plannedOrderModelSerializer =
    new _$PlannedOrderModelSerializer();
Serializer<DayModel> _$dayModelSerializer = new _$DayModelSerializer();
Serializer<Schedules> _$schedulesSerializer = new _$SchedulesSerializer();
Serializer<InformRes> _$informResSerializer = new _$InformResSerializer();
Serializer<Inform> _$informSerializer = new _$InformSerializer();
Serializer<InformCreateRes> _$informCreateResSerializer =
    new _$InformCreateResSerializer();
Serializer<ProductCatalogResponse> _$productCatalogResponseSerializer =
    new _$ProductCatalogResponseSerializer();
Serializer<ProductModelResponse> _$productModelResponseSerializer =
    new _$ProductModelResponseSerializer();
Serializer<ProductCategory> _$productCategorySerializer =
    new _$ProductCategorySerializer();
Serializer<ProductDetailModel> _$productDetailModelSerializer =
    new _$ProductDetailModelSerializer();
Serializer<NutritionModel> _$nutritionModelSerializer =
    new _$NutritionModelSerializer();
Serializer<SectionModel> _$sectionModelSerializer =
    new _$SectionModelSerializer();

class _$CatalogSerializer implements StructuredSerializer<Catalog> {
  @override
  final Iterable<Type> types = const [Catalog, _$Catalog];
  @override
  final String wireName = 'Catalog';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Catalog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(SubCategoryModel),
            ]),
          ),
        );
    }
    value = object.currentPage;
    if (value != null) {
      result
        ..add('current_page')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.totalPages;
    if (value != null) {
      result
        ..add('total_pages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.hasNext;
    if (value != null) {
      result
        ..add('has_next')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.hasPrevious;
    if (value != null) {
      result
        ..add('has_previous')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    return result;
  }

  @override
  Catalog deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new CatalogBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(SubCategoryModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'current_page':
          result.currentPage =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'total_pages':
          result.totalPages =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'has_next':
          result.hasNext =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'has_previous':
          result.hasPrevious =
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

class _$SubCategoryModelSerializer
    implements StructuredSerializer<SubCategoryModel> {
  @override
  final Iterable<Type> types = const [SubCategoryModel, _$SubCategoryModel];
  @override
  final String wireName = 'SubCategoryModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SubCategoryModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.subCategoryTitle;
    if (value != null) {
      result
        ..add('sub_category_title')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(ItemModel),
            ]),
          ),
        );
    }
    value = object.parents;
    if (value != null) {
      result
        ..add('parents')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(StoryModel),
            ]),
          ),
        );
    }
    value = object.children;
    if (value != null) {
      result
        ..add('children')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(StoryModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  SubCategoryModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SubCategoryModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'sub_category_title':
          result.subCategoryTitle =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(ItemModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'parents':
          result.parents.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(StoryModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'children':
          result.children.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(StoryModel),
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

class _$ItemModelSerializer implements StructuredSerializer<ItemModel> {
  @override
  final Iterable<Type> types = const [ItemModel, _$ItemModel];
  @override
  final String wireName = 'ItemModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ItemModel object, {
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
    value = object.backgroundImage;
    if (value != null) {
      result
        ..add('background_image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.flag;
    if (value != null) {
      result
        ..add('flag')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.families;
    if (value != null) {
      result
        ..add('families')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(FamilyModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  ItemModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ItemModelBuilder();

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
        case 'background_image':
          result.backgroundImage =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'flag':
          result.flag =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'families':
          result.families.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(FamilyModel),
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

class _$FamilyModelSerializer implements StructuredSerializer<FamilyModel> {
  @override
  final Iterable<Type> types = const [FamilyModel, _$FamilyModel];
  @override
  final String wireName = 'FamilyModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    FamilyModel object, {
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
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    value = object.productCount;
    if (value != null) {
      result
        ..add('product_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  FamilyModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new FamilyModelBuilder();

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
        case 'image':
          result.image =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
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
        case 'product_count':
          result.productCount =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$CategoryListModelSerializer
    implements StructuredSerializer<CategoryListModel> {
  @override
  final Iterable<Type> types = const [CategoryListModel, _$CategoryListModel];
  @override
  final String wireName = 'CategoryListModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    CategoryListModel object, {
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
    value = object.categories;
    if (value != null) {
      result
        ..add('categories')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(ProductModel)]),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  CategoryListModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new CategoryListModelBuilder();

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
        case 'categories':
          result.categories.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(BuiltList, const [
                      const FullType(ProductModel),
                    ]),
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

class _$ProductModelSerializer implements StructuredSerializer<ProductModel> {
  @override
  final Iterable<Type> types = const [ProductModel, _$ProductModel];
  @override
  final String wireName = 'ProductModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ProductModel object, {
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
    value = object.product;
    if (value != null) {
      result
        ..add('product')
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
    value = object.shortName;
    if (value != null) {
      result
        ..add('short_name')
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
    value = object.imageGrid;
    if (value != null) {
      result
        ..add('image_grid')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.picture;
    if (value != null) {
      result
        ..add('picture')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.flag;
    if (value != null) {
      result
        ..add('flag')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.volume;
    if (value != null) {
      result
        ..add('volume')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.previousPrice;
    if (value != null) {
      result
        ..add('previous_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.volumeUnit;
    if (value != null) {
      result
        ..add('volume_unit')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.availableQuantity;
    if (value != null) {
      result
        ..add('available_quantity')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
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
    value = object.time;
    if (value != null) {
      result
        ..add('time')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isNew;
    if (value != null) {
      result
        ..add('is_new')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.isPopular;
    if (value != null) {
      result
        ..add('is_popular')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.isAutoAdded;
    if (value != null) {
      result
        ..add('is_auto_added')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.productCount;
    if (value != null) {
      result
        ..add('product_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ProductModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ProductModelBuilder();

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
        case 'product':
          result.product =
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
        case 'short_name':
          result.shortName =
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
        case 'image_grid':
          result.imageGrid =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'picture':
          result.picture =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'flag':
          result.flag =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'volume':
          result.volume =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'previous_price':
          result.previousPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'volume_unit':
          result.volumeUnit =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'available_quantity':
          result.availableQuantity =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'price':
          result.price =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'date':
          result.date =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'time':
          result.time =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'is_new':
          result.isNew =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'is_popular':
          result.isPopular =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'is_auto_added':
          result.isAutoAdded =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'product_count':
          result.productCount =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ModifiedModelSerializer implements StructuredSerializer<ModifiedModel> {
  @override
  final Iterable<Type> types = const [ModifiedModel, _$ModifiedModel];
  @override
  final String wireName = 'ModifiedModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ModifiedModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.product;
    if (value != null) {
      result
        ..add('product')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(ProductModel),
          ),
        );
    }
    value = object.requested;
    if (value != null) {
      result
        ..add('requested')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.available;
    if (value != null) {
      result
        ..add('available')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ModifiedModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ModifiedModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'product':
          result.product.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(ProductModel),
                )!
                as ProductModel,
          );
          break;
        case 'requested':
          result.requested =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'available':
          result.available =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$InformModelSerializer implements StructuredSerializer<InformModel> {
  @override
  final Iterable<Type> types = const [InformModel, _$InformModel];
  @override
  final String wireName = 'InformModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    InformModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.product;
    if (value != null) {
      result
        ..add('product')
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
  InformModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new InformModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'product':
          result.product =
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

class _$OrderModelSerializer implements StructuredSerializer<OrderModel> {
  @override
  final Iterable<Type> types = const [OrderModel, _$OrderModel];
  @override
  final String wireName = 'OrderModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    OrderModel object, {
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
    value = object.orderId;
    if (value != null) {
      result
        ..add('order_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.client;
    if (value != null) {
      result
        ..add('client')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.checkNumber;
    if (value != null) {
      result
        ..add('check_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
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
    value = object.payment;
    if (value != null) {
      result
        ..add('payment')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    value = object.deliveryTime;
    if (value != null) {
      result
        ..add('delivery_time')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.acceptedAt;
    if (value != null) {
      result
        ..add('accepted_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.collectedAt;
    if (value != null) {
      result
        ..add('collected_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.deliveredAt;
    if (value != null) {
      result
        ..add('delivered_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.deliveryStartedAt;
    if (value != null) {
      result
        ..add('delivery_started_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.totalAmount;
    if (value != null) {
      result
        ..add('total_amount')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.itemsCount;
    if (value != null) {
      result
        ..add('items_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.amountToPay;
    if (value != null) {
      result
        ..add('amount_to_pay')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.deliveryPrice;
    if (value != null) {
      result
        ..add('delivery_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.servicePrice;
    if (value != null) {
      result
        ..add('service_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.promocodePrice;
    if (value != null) {
      result
        ..add('promocode_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.fiscalCheck;
    if (value != null) {
      result
        ..add('fiscal_check')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isFirstOrder;
    if (value != null) {
      result
        ..add('is_first_order')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.orderThrought;
    if (value != null) {
      result
        ..add('order_throught')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(ProductModel),
            ]),
          ),
        );
    }
    value = object.orderItemsImages;
    if (value != null) {
      result
        ..add('order_items_images')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(String),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  OrderModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new OrderModelBuilder();

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
        case 'order_id':
          result.orderId =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'client':
          result.client =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'check_number':
          result.checkNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'phone':
          result.phone =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
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
        case 'payment':
          result.payment =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'actual_order_create_time':
          result.actualOrderCreateTime =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'delivery_time':
          result.deliveryTime =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'accepted_at':
          result.acceptedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'collected_at':
          result.collectedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'delivered_at':
          result.deliveredAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'delivery_started_at':
          result.deliveryStartedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'total_amount':
          result.totalAmount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'items_count':
          result.itemsCount =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'amount_to_pay':
          result.amountToPay =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'delivery_price':
          result.deliveryPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'service_price':
          result.servicePrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'promocode_price':
          result.promocodePrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'fiscal_check':
          result.fiscalCheck =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'is_first_order':
          result.isFirstOrder =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'order_throught':
          result.orderThrought.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(ProductModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'order_items_images':
          result.orderItemsImages.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
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

class _$OrderReqSerializer implements StructuredSerializer<OrderReq> {
  @override
  final Iterable<Type> types = const [OrderReq, _$OrderReq];
  @override
  final String wireName = 'OrderReq';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    OrderReq object, {
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
    value = object.totalAmount;
    if (value != null) {
      result
        ..add('total_amount')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
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
    value = object.deliveryPrice;
    if (value != null) {
      result
        ..add('delivery_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.expresPrice;
    if (value != null) {
      result
        ..add('expres_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.servicePrice;
    if (value != null) {
      result
        ..add('service_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.minimumPrice;
    if (value != null) {
      result
        ..add('minimum_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.fromBalance;
    if (value != null) {
      result
        ..add('from_balance')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.tipsPrice;
    if (value != null) {
      result
        ..add('tips_price')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.estimatedOrderTime;
    if (value != null) {
      result
        ..add('estimated_order_time')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.payment;
    if (value != null) {
      result
        ..add('payment')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.promo;
    if (value != null) {
      result
        ..add('promo')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isAdditional;
    if (value != null) {
      result
        ..add('is_additional')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.orderToAdd;
    if (value != null) {
      result
        ..add('order_to_add')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  OrderReq deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new OrderReqBuilder();

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
        case 'total_amount':
          result.totalAmount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
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
        case 'comment':
          result.comment =
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
        case 'delivery_price':
          result.deliveryPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'expres_price':
          result.expresPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'service_price':
          result.servicePrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'minimum_price':
          result.minimumPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'from_balance':
          result.fromBalance =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'tips_price':
          result.tipsPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'estimated_order_time':
          result.estimatedOrderTime =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'payment':
          result.payment =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'address':
          result.address =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'promo':
          result.promo =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'is_additional':
          result.isAdditional =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'order_to_add':
          result.orderToAdd =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'category':
          result.category =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$CategoriesSerializer implements StructuredSerializer<Categories> {
  @override
  final Iterable<Type> types = const [Categories, _$Categories];
  @override
  final String wireName = 'Categories';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Categories object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.categoryName;
    if (value != null) {
      result
        ..add('category_name')
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
    value = object.subCategories;
    if (value != null) {
      result
        ..add('sub_categories')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(SubCategories),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  Categories deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new CategoriesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'category_name':
          result.categoryName =
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
        case 'sub_categories':
          result.subCategories.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(SubCategories),
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

class _$SubCategoriesSerializer implements StructuredSerializer<SubCategories> {
  @override
  final Iterable<Type> types = const [SubCategories, _$SubCategories];
  @override
  final String wireName = 'SubCategories';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SubCategories object, {
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
  SubCategories deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SubCategoriesBuilder();

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

class _$OrderStatusResSerializer
    implements StructuredSerializer<OrderStatusRes> {
  @override
  final Iterable<Type> types = const [OrderStatusRes, _$OrderStatusRes];
  @override
  final String wireName = 'OrderStatusRes';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    OrderStatusRes object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.checkNumber;
    if (value != null) {
      result
        ..add('check_number')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    value = object.deliveryTime;
    if (value != null) {
      result
        ..add('delivery_time')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.deliveryStartedAt;
    if (value != null) {
      result
        ..add('delivery_started_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.deliveredAt;
    if (value != null) {
      result
        ..add('delivered_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.collectedAt;
    if (value != null) {
      result
        ..add('collected_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.acceptedAt;
    if (value != null) {
      result
        ..add('accepted_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  OrderStatusRes deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new OrderStatusResBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'address':
          result.address =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'check_number':
          result.checkNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'actual_order_create_time':
          result.actualOrderCreateTime =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'delivery_time':
          result.deliveryTime =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'delivery_started_at':
          result.deliveryStartedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'delivered_at':
          result.deliveredAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'collected_at':
          result.collectedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'accepted_at':
          result.acceptedAt =
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

class _$PlannedOrderListModelSerializer
    implements StructuredSerializer<PlannedOrderListModel> {
  @override
  final Iterable<Type> types = const [
    PlannedOrderListModel,
    _$PlannedOrderListModel,
  ];
  @override
  final String wireName = 'PlannedOrderListModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    PlannedOrderListModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
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
    value = object.totalPages;
    if (value != null) {
      result
        ..add('total_pages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.results;
    if (value != null) {
      result
        ..add('results')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(PlannedOrderModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  PlannedOrderListModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new PlannedOrderListModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'total_pages':
          result.totalPages =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'results':
          result.results.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(PlannedOrderModel),
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

class _$PlannedOrderModelSerializer
    implements StructuredSerializer<PlannedOrderModel> {
  @override
  final Iterable<Type> types = const [PlannedOrderModel, _$PlannedOrderModel];
  @override
  final String wireName = 'PlannedOrderModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    PlannedOrderModel object, {
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
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(ProductModel),
            ]),
          ),
        );
    }
    value = object.schedules;
    if (value != null) {
      result
        ..add('schedules')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(Schedules),
            ]),
          ),
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
    value = object.addressTitle;
    if (value != null) {
      result
        ..add('address_title')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.paymentName;
    if (value != null) {
      result
        ..add('payment_name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.client;
    if (value != null) {
      result
        ..add('client')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.paymentType;
    if (value != null) {
      result
        ..add('payment_type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.totalAmountValue;
    if (value != null) {
      result
        ..add('total_amount')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.itemsCount;
    if (value != null) {
      result
        ..add('items_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.time;
    if (value != null) {
      result
        ..add('time')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.dayOfWeeks;
    if (value != null) {
      result
        ..add('day_of_weeks')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.images;
    if (value != null) {
      result
        ..add('images')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(String),
            ]),
          ),
        );
    }
    value = object.weeks;
    if (value != null) {
      result
        ..add('weeks')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(DayModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  PlannedOrderModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new PlannedOrderModelBuilder();

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
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(ProductModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'schedules':
          result.schedules.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(Schedules),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'address_name':
          result.addressName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'address_title':
          result.addressTitle =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'payment_name':
          result.paymentName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
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
        case 'client':
          result.client =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'payment_type':
          result.paymentType =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'address':
          result.address =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'total_amount':
          result.totalAmountValue =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'items_count':
          result.itemsCount =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'time':
          result.time =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'day_of_weeks':
          result.dayOfWeeks =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'images':
          result.images.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'weeks':
          result.weeks.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(DayModel),
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

class _$DayModelSerializer implements StructuredSerializer<DayModel> {
  @override
  final Iterable<Type> types = const [DayModel, _$DayModel];
  @override
  final String wireName = 'DayModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    DayModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.day;
    if (value != null) {
      result
        ..add('day')
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
    return result;
  }

  @override
  DayModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new DayModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'day':
          result.day =
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
      }
    }

    return result.build();
  }
}

class _$SchedulesSerializer implements StructuredSerializer<Schedules> {
  @override
  final Iterable<Type> types = const [Schedules, _$Schedules];
  @override
  final String wireName = 'Schedules';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Schedules object, {
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
    value = object.dayOfWeek;
    if (value != null) {
      result
        ..add('day_of_week')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.time;
    if (value != null) {
      result
        ..add('time')
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
    return result;
  }

  @override
  Schedules deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SchedulesBuilder();

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
        case 'day_of_week':
          result.dayOfWeek =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'time':
          result.time =
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
      }
    }

    return result.build();
  }
}

class _$InformResSerializer implements StructuredSerializer<InformRes> {
  @override
  final Iterable<Type> types = const [InformRes, _$InformRes];
  @override
  final String wireName = 'InformRes';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    InformRes object, {
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
    value = object.product;
    if (value != null) {
      result
        ..add('product')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(ProductModel),
          ),
        );
    }
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isSent;
    if (value != null) {
      result
        ..add('is_sent')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
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
  InformRes deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new InformResBuilder();

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
        case 'product':
          result.product.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(ProductModel),
                )!
                as ProductModel,
          );
          break;
        case 'count':
          result.count =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'is_sent':
          result.isSent =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
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

class _$InformSerializer implements StructuredSerializer<Inform> {
  @override
  final Iterable<Type> types = const [Inform, _$Inform];
  @override
  final String wireName = 'Inform';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Inform object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
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
    value = object.totalPages;
    if (value != null) {
      result
        ..add('total_pages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.results;
    if (value != null) {
      result
        ..add('results')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(InformRes),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  Inform deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new InformBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'total_pages':
          result.totalPages =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'results':
          result.results.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(InformRes),
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

class _$InformCreateResSerializer
    implements StructuredSerializer<InformCreateRes> {
  @override
  final Iterable<Type> types = const [InformCreateRes, _$InformCreateRes];
  @override
  final String wireName = 'InformCreateRes';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    InformCreateRes object, {
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
    value = object.product;
    if (value != null) {
      result
        ..add('product')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isSent;
    if (value != null) {
      result
        ..add('is_sent')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
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
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.client;
    if (value != null) {
      result
        ..add('client')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  InformCreateRes deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new InformCreateResBuilder();

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
        case 'product':
          result.product =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'count':
          result.count =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'is_sent':
          result.isSent =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
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
        case 'client':
          result.client =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductCatalogResponseSerializer
    implements StructuredSerializer<ProductCatalogResponse> {
  @override
  final Iterable<Type> types = const [
    ProductCatalogResponse,
    _$ProductCatalogResponse,
  ];
  @override
  final String wireName = 'ProductCatalogResponse';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ProductCatalogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.next;
    if (value != null) {
      result
        ..add('next')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.previous;
    if (value != null) {
      result
        ..add('previous')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.results;
    if (value != null) {
      result
        ..add('results')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(ProductCategory),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  ProductCatalogResponse deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ProductCatalogResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'count':
          result.count =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'next':
          result.next =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'previous':
          result.previous =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'results':
          result.results.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(ProductCategory),
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

class _$ProductModelResponseSerializer
    implements StructuredSerializer<ProductModelResponse> {
  @override
  final Iterable<Type> types = const [
    ProductModelResponse,
    _$ProductModelResponse,
  ];
  @override
  final String wireName = 'ProductModelResponse';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ProductModelResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
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
    value = object.totalPages;
    if (value != null) {
      result
        ..add('total_pages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.results;
    if (value != null) {
      result
        ..add('results')
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
  ProductModelResponse deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ProductModelResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'total_pages':
          result.totalPages =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'results':
          result.results.replace(
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

class _$ProductCategorySerializer
    implements StructuredSerializer<ProductCategory> {
  @override
  final Iterable<Type> types = const [ProductCategory, _$ProductCategory];
  @override
  final String wireName = 'ProductCategory';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ProductCategory object, {
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
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
    value = object.productCount;
    if (value != null) {
      result
        ..add('product_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ProductCategory deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ProductCategoryBuilder();

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
        case 'category':
          result.category =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
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
        case 'product_count':
          result.productCount =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductDetailModelSerializer
    implements StructuredSerializer<ProductDetailModel> {
  @override
  final Iterable<Type> types = const [ProductDetailModel, _$ProductDetailModel];
  @override
  final String wireName = 'ProductDetailModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ProductDetailModel object, {
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
    value = object.flag;
    if (value != null) {
      result
        ..add('flag')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.expireDate;
    if (value != null) {
      result
        ..add('expire_date')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isNew;
    if (value != null) {
      result
        ..add('is_new')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    value = object.isPopular;
    if (value != null) {
      result
        ..add('is_popular')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
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
    value = object.nutrition;
    if (value != null) {
      result
        ..add('nutrition')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(NutritionModel),
          ),
        );
    }
    return result;
  }

  @override
  ProductDetailModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ProductDetailModelBuilder();

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
        case 'flag':
          result.flag =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'expire_date':
          result.expireDate =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'is_new':
          result.isNew =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'is_popular':
          result.isPopular =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'nutrition':
          result.nutrition.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(NutritionModel),
                )!
                as NutritionModel,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$NutritionModelSerializer
    implements StructuredSerializer<NutritionModel> {
  @override
  final Iterable<Type> types = const [NutritionModel, _$NutritionModel];
  @override
  final String wireName = 'NutritionModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    NutritionModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.proteins;
    if (value != null) {
      result
        ..add('proteins')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.fats;
    if (value != null) {
      result
        ..add('fats')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.carbohydrates;
    if (value != null) {
      result
        ..add('carbohydrates')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.calories;
    if (value != null) {
      result
        ..add('calories')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    return result;
  }

  @override
  NutritionModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new NutritionModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'proteins':
          result.proteins =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'fats':
          result.fats =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'carbohydrates':
          result.carbohydrates =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'calories':
          result.calories =
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

class _$SectionModelSerializer implements StructuredSerializer<SectionModel> {
  @override
  final Iterable<Type> types = const [SectionModel, _$SectionModel];
  @override
  final String wireName = 'SectionModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    SectionModel object, {
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
    value = object.priority;
    if (value != null) {
      result
        ..add('priority')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isActive;
    if (value != null) {
      result
        ..add('is_active')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
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
              const FullType(ProductModel),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  SectionModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new SectionModelBuilder();

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
        case 'priority':
          result.priority =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'is_active':
          result.isActive =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
        case 'categories':
          result.categories.replace(
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

class _$Catalog extends Catalog {
  @override
  final BuiltList<SubCategoryModel>? data;
  @override
  final int? currentPage;
  @override
  final int? totalPages;
  @override
  final bool? hasNext;
  @override
  final bool? hasPrevious;

  factory _$Catalog([void Function(CatalogBuilder)? updates]) =>
      (new CatalogBuilder()..update(updates))._build();

  _$Catalog._({
    this.data,
    this.currentPage,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  }) : super._();

  @override
  Catalog rebuild(void Function(CatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CatalogBuilder toBuilder() => new CatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Catalog &&
        data == other.data &&
        currentPage == other.currentPage &&
        totalPages == other.totalPages &&
        hasNext == other.hasNext &&
        hasPrevious == other.hasPrevious;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, hasNext.hashCode);
    _$hash = $jc(_$hash, hasPrevious.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Catalog')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('totalPages', totalPages)
          ..add('hasNext', hasNext)
          ..add('hasPrevious', hasPrevious))
        .toString();
  }
}

class CatalogBuilder implements Builder<Catalog, CatalogBuilder> {
  _$Catalog? _$v;

  ListBuilder<SubCategoryModel>? _data;
  ListBuilder<SubCategoryModel> get data =>
      _$this._data ??= new ListBuilder<SubCategoryModel>();
  set data(ListBuilder<SubCategoryModel>? data) => _$this._data = data;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  bool? _hasNext;
  bool? get hasNext => _$this._hasNext;
  set hasNext(bool? hasNext) => _$this._hasNext = hasNext;

  bool? _hasPrevious;
  bool? get hasPrevious => _$this._hasPrevious;
  set hasPrevious(bool? hasPrevious) => _$this._hasPrevious = hasPrevious;

  CatalogBuilder();

  CatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _currentPage = $v.currentPage;
      _totalPages = $v.totalPages;
      _hasNext = $v.hasNext;
      _hasPrevious = $v.hasPrevious;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Catalog other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Catalog;
  }

  @override
  void update(void Function(CatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Catalog build() => _build();

  _$Catalog _build() {
    _$Catalog _$result;
    try {
      _$result =
          _$v ??
          new _$Catalog._(
            data: _data?.build(),
            currentPage: currentPage,
            totalPages: totalPages,
            hasNext: hasNext,
            hasPrevious: hasPrevious,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'Catalog',
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

class _$SubCategoryModel extends SubCategoryModel {
  @override
  final String? subCategoryTitle;
  @override
  final BuiltList<ItemModel>? items;
  @override
  final BuiltList<StoryModel>? parents;
  @override
  final BuiltList<StoryModel>? children;

  factory _$SubCategoryModel([
    void Function(SubCategoryModelBuilder)? updates,
  ]) => (new SubCategoryModelBuilder()..update(updates))._build();

  _$SubCategoryModel._({
    this.subCategoryTitle,
    this.items,
    this.parents,
    this.children,
  }) : super._();

  @override
  SubCategoryModel rebuild(void Function(SubCategoryModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubCategoryModelBuilder toBuilder() =>
      new SubCategoryModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubCategoryModel &&
        subCategoryTitle == other.subCategoryTitle &&
        items == other.items &&
        parents == other.parents &&
        children == other.children;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subCategoryTitle.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, parents.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubCategoryModel')
          ..add('subCategoryTitle', subCategoryTitle)
          ..add('items', items)
          ..add('parents', parents)
          ..add('children', children))
        .toString();
  }
}

class SubCategoryModelBuilder
    implements Builder<SubCategoryModel, SubCategoryModelBuilder> {
  _$SubCategoryModel? _$v;

  String? _subCategoryTitle;
  String? get subCategoryTitle => _$this._subCategoryTitle;
  set subCategoryTitle(String? subCategoryTitle) =>
      _$this._subCategoryTitle = subCategoryTitle;

  ListBuilder<ItemModel>? _items;
  ListBuilder<ItemModel> get items =>
      _$this._items ??= new ListBuilder<ItemModel>();
  set items(ListBuilder<ItemModel>? items) => _$this._items = items;

  ListBuilder<StoryModel>? _parents;
  ListBuilder<StoryModel> get parents =>
      _$this._parents ??= new ListBuilder<StoryModel>();
  set parents(ListBuilder<StoryModel>? parents) => _$this._parents = parents;

  ListBuilder<StoryModel>? _children;
  ListBuilder<StoryModel> get children =>
      _$this._children ??= new ListBuilder<StoryModel>();
  set children(ListBuilder<StoryModel>? children) =>
      _$this._children = children;

  SubCategoryModelBuilder();

  SubCategoryModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subCategoryTitle = $v.subCategoryTitle;
      _items = $v.items?.toBuilder();
      _parents = $v.parents?.toBuilder();
      _children = $v.children?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubCategoryModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubCategoryModel;
  }

  @override
  void update(void Function(SubCategoryModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubCategoryModel build() => _build();

  _$SubCategoryModel _build() {
    _$SubCategoryModel _$result;
    try {
      _$result =
          _$v ??
          new _$SubCategoryModel._(
            subCategoryTitle: subCategoryTitle,
            items: _items?.build(),
            parents: _parents?.build(),
            children: _children?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
        _$failedField = 'parents';
        _parents?.build();
        _$failedField = 'children';
        _children?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'SubCategoryModel',
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

class _$ItemModel extends ItemModel {
  @override
  final String? name;
  @override
  final String? backgroundImage;
  @override
  final String? flag;
  @override
  final BuiltList<FamilyModel>? families;

  factory _$ItemModel([void Function(ItemModelBuilder)? updates]) =>
      (new ItemModelBuilder()..update(updates))._build();

  _$ItemModel._({this.name, this.backgroundImage, this.flag, this.families})
    : super._();

  @override
  ItemModel rebuild(void Function(ItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemModelBuilder toBuilder() => new ItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ItemModel &&
        name == other.name &&
        backgroundImage == other.backgroundImage &&
        flag == other.flag &&
        families == other.families;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, backgroundImage.hashCode);
    _$hash = $jc(_$hash, flag.hashCode);
    _$hash = $jc(_$hash, families.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ItemModel')
          ..add('name', name)
          ..add('backgroundImage', backgroundImage)
          ..add('flag', flag)
          ..add('families', families))
        .toString();
  }
}

class ItemModelBuilder implements Builder<ItemModel, ItemModelBuilder> {
  _$ItemModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _backgroundImage;
  String? get backgroundImage => _$this._backgroundImage;
  set backgroundImage(String? backgroundImage) =>
      _$this._backgroundImage = backgroundImage;

  String? _flag;
  String? get flag => _$this._flag;
  set flag(String? flag) => _$this._flag = flag;

  ListBuilder<FamilyModel>? _families;
  ListBuilder<FamilyModel> get families =>
      _$this._families ??= new ListBuilder<FamilyModel>();
  set families(ListBuilder<FamilyModel>? families) =>
      _$this._families = families;

  ItemModelBuilder();

  ItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _backgroundImage = $v.backgroundImage;
      _flag = $v.flag;
      _families = $v.families?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ItemModel;
  }

  @override
  void update(void Function(ItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ItemModel build() => _build();

  _$ItemModel _build() {
    _$ItemModel _$result;
    try {
      _$result =
          _$v ??
          new _$ItemModel._(
            name: name,
            backgroundImage: backgroundImage,
            flag: flag,
            families: _families?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'families';
        _families?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ItemModel',
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

class _$FamilyModel extends FamilyModel {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? image;
  @override
  final BuiltList<ProductModel>? products;
  @override
  final int? productCount;

  factory _$FamilyModel([void Function(FamilyModelBuilder)? updates]) =>
      (new FamilyModelBuilder()..update(updates))._build();

  _$FamilyModel._({
    this.id,
    this.name,
    this.image,
    this.products,
    this.productCount,
  }) : super._();

  @override
  FamilyModel rebuild(void Function(FamilyModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FamilyModelBuilder toBuilder() => new FamilyModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FamilyModel &&
        id == other.id &&
        name == other.name &&
        image == other.image &&
        products == other.products &&
        productCount == other.productCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, productCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FamilyModel')
          ..add('id', id)
          ..add('name', name)
          ..add('image', image)
          ..add('products', products)
          ..add('productCount', productCount))
        .toString();
  }
}

class FamilyModelBuilder implements Builder<FamilyModel, FamilyModelBuilder> {
  _$FamilyModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  ListBuilder<ProductModel>? _products;
  ListBuilder<ProductModel> get products =>
      _$this._products ??= new ListBuilder<ProductModel>();
  set products(ListBuilder<ProductModel>? products) =>
      _$this._products = products;

  int? _productCount;
  int? get productCount => _$this._productCount;
  set productCount(int? productCount) => _$this._productCount = productCount;

  FamilyModelBuilder();

  FamilyModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _image = $v.image;
      _products = $v.products?.toBuilder();
      _productCount = $v.productCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FamilyModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FamilyModel;
  }

  @override
  void update(void Function(FamilyModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FamilyModel build() => _build();

  _$FamilyModel _build() {
    _$FamilyModel _$result;
    try {
      _$result =
          _$v ??
          new _$FamilyModel._(
            id: id,
            name: name,
            image: image,
            products: _products?.build(),
            productCount: productCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        _products?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'FamilyModel',
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

class _$CategoryListModel extends CategoryListModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final BuiltList<BuiltList<ProductModel>>? categories;

  factory _$CategoryListModel([
    void Function(CategoryListModelBuilder)? updates,
  ]) => (new CategoryListModelBuilder()..update(updates))._build();

  _$CategoryListModel._({this.id, this.title, this.categories}) : super._();

  @override
  CategoryListModel rebuild(void Function(CategoryListModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryListModelBuilder toBuilder() =>
      new CategoryListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoryListModel &&
        id == other.id &&
        title == other.title &&
        categories == other.categories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CategoryListModel')
          ..add('id', id)
          ..add('title', title)
          ..add('categories', categories))
        .toString();
  }
}

class CategoryListModelBuilder
    implements Builder<CategoryListModel, CategoryListModelBuilder> {
  _$CategoryListModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<BuiltList<ProductModel>>? _categories;
  ListBuilder<BuiltList<ProductModel>> get categories =>
      _$this._categories ??= new ListBuilder<BuiltList<ProductModel>>();
  set categories(ListBuilder<BuiltList<ProductModel>>? categories) =>
      _$this._categories = categories;

  CategoryListModelBuilder();

  CategoryListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _categories = $v.categories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoryListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CategoryListModel;
  }

  @override
  void update(void Function(CategoryListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CategoryListModel build() => _build();

  _$CategoryListModel _build() {
    _$CategoryListModel _$result;
    try {
      _$result =
          _$v ??
          new _$CategoryListModel._(
            id: id,
            title: title,
            categories: _categories?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        _categories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'CategoryListModel',
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

class _$ProductModel extends ProductModel {
  @override
  final int? id;
  @override
  final int? product;
  @override
  final int? count;
  @override
  final String? title;
  @override
  final String? shortName;
  @override
  final String? image;
  @override
  final String? imageGrid;
  @override
  final String? picture;
  @override
  final String? flag;
  @override
  final double? volume;
  @override
  final double? previousPrice;
  @override
  final String? volumeUnit;
  @override
  final int? availableQuantity;
  @override
  final double? price;
  @override
  final String? date;
  @override
  final String? time;
  @override
  final bool? isNew;
  @override
  final bool? isPopular;
  @override
  final bool? isAutoAdded;
  @override
  final int? productCount;

  factory _$ProductModel([void Function(ProductModelBuilder)? updates]) =>
      (new ProductModelBuilder()..update(updates))._build();

  _$ProductModel._({
    this.id,
    this.product,
    this.count,
    this.title,
    this.shortName,
    this.image,
    this.imageGrid,
    this.picture,
    this.flag,
    this.volume,
    this.previousPrice,
    this.volumeUnit,
    this.availableQuantity,
    this.price,
    this.date,
    this.time,
    this.isNew,
    this.isPopular,
    this.isAutoAdded,
    this.productCount,
  }) : super._();

  @override
  ProductModel rebuild(void Function(ProductModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductModelBuilder toBuilder() => new ProductModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductModel &&
        id == other.id &&
        product == other.product &&
        count == other.count &&
        title == other.title &&
        shortName == other.shortName &&
        image == other.image &&
        imageGrid == other.imageGrid &&
        picture == other.picture &&
        flag == other.flag &&
        volume == other.volume &&
        previousPrice == other.previousPrice &&
        volumeUnit == other.volumeUnit &&
        availableQuantity == other.availableQuantity &&
        price == other.price &&
        date == other.date &&
        time == other.time &&
        isNew == other.isNew &&
        isPopular == other.isPopular &&
        isAutoAdded == other.isAutoAdded &&
        productCount == other.productCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, shortName.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, imageGrid.hashCode);
    _$hash = $jc(_$hash, picture.hashCode);
    _$hash = $jc(_$hash, flag.hashCode);
    _$hash = $jc(_$hash, volume.hashCode);
    _$hash = $jc(_$hash, previousPrice.hashCode);
    _$hash = $jc(_$hash, volumeUnit.hashCode);
    _$hash = $jc(_$hash, availableQuantity.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jc(_$hash, isNew.hashCode);
    _$hash = $jc(_$hash, isPopular.hashCode);
    _$hash = $jc(_$hash, isAutoAdded.hashCode);
    _$hash = $jc(_$hash, productCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductModel')
          ..add('id', id)
          ..add('product', product)
          ..add('count', count)
          ..add('title', title)
          ..add('shortName', shortName)
          ..add('image', image)
          ..add('imageGrid', imageGrid)
          ..add('picture', picture)
          ..add('flag', flag)
          ..add('volume', volume)
          ..add('previousPrice', previousPrice)
          ..add('volumeUnit', volumeUnit)
          ..add('availableQuantity', availableQuantity)
          ..add('price', price)
          ..add('date', date)
          ..add('time', time)
          ..add('isNew', isNew)
          ..add('isPopular', isPopular)
          ..add('isAutoAdded', isAutoAdded)
          ..add('productCount', productCount))
        .toString();
  }
}

class ProductModelBuilder
    implements Builder<ProductModel, ProductModelBuilder> {
  _$ProductModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _product;
  int? get product => _$this._product;
  set product(int? product) => _$this._product = product;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _shortName;
  String? get shortName => _$this._shortName;
  set shortName(String? shortName) => _$this._shortName = shortName;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _imageGrid;
  String? get imageGrid => _$this._imageGrid;
  set imageGrid(String? imageGrid) => _$this._imageGrid = imageGrid;

  String? _picture;
  String? get picture => _$this._picture;
  set picture(String? picture) => _$this._picture = picture;

  String? _flag;
  String? get flag => _$this._flag;
  set flag(String? flag) => _$this._flag = flag;

  double? _volume;
  double? get volume => _$this._volume;
  set volume(double? volume) => _$this._volume = volume;

  double? _previousPrice;
  double? get previousPrice => _$this._previousPrice;
  set previousPrice(double? previousPrice) =>
      _$this._previousPrice = previousPrice;

  String? _volumeUnit;
  String? get volumeUnit => _$this._volumeUnit;
  set volumeUnit(String? volumeUnit) => _$this._volumeUnit = volumeUnit;

  int? _availableQuantity;
  int? get availableQuantity => _$this._availableQuantity;
  set availableQuantity(int? availableQuantity) =>
      _$this._availableQuantity = availableQuantity;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  String? _time;
  String? get time => _$this._time;
  set time(String? time) => _$this._time = time;

  bool? _isNew;
  bool? get isNew => _$this._isNew;
  set isNew(bool? isNew) => _$this._isNew = isNew;

  bool? _isPopular;
  bool? get isPopular => _$this._isPopular;
  set isPopular(bool? isPopular) => _$this._isPopular = isPopular;

  bool? _isAutoAdded;
  bool? get isAutoAdded => _$this._isAutoAdded;
  set isAutoAdded(bool? isAutoAdded) => _$this._isAutoAdded = isAutoAdded;

  int? _productCount;
  int? get productCount => _$this._productCount;
  set productCount(int? productCount) => _$this._productCount = productCount;

  ProductModelBuilder();

  ProductModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _product = $v.product;
      _count = $v.count;
      _title = $v.title;
      _shortName = $v.shortName;
      _image = $v.image;
      _imageGrid = $v.imageGrid;
      _picture = $v.picture;
      _flag = $v.flag;
      _volume = $v.volume;
      _previousPrice = $v.previousPrice;
      _volumeUnit = $v.volumeUnit;
      _availableQuantity = $v.availableQuantity;
      _price = $v.price;
      _date = $v.date;
      _time = $v.time;
      _isNew = $v.isNew;
      _isPopular = $v.isPopular;
      _isAutoAdded = $v.isAutoAdded;
      _productCount = $v.productCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductModel;
  }

  @override
  void update(void Function(ProductModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductModel build() => _build();

  _$ProductModel _build() {
    final _$result =
        _$v ??
        new _$ProductModel._(
          id: id,
          product: product,
          count: count,
          title: title,
          shortName: shortName,
          image: image,
          imageGrid: imageGrid,
          picture: picture,
          flag: flag,
          volume: volume,
          previousPrice: previousPrice,
          volumeUnit: volumeUnit,
          availableQuantity: availableQuantity,
          price: price,
          date: date,
          time: time,
          isNew: isNew,
          isPopular: isPopular,
          isAutoAdded: isAutoAdded,
          productCount: productCount,
        );
    replace(_$result);
    return _$result;
  }
}

class _$ModifiedModel extends ModifiedModel {
  @override
  final ProductModel? product;
  @override
  final int? requested;
  @override
  final int? available;

  factory _$ModifiedModel([void Function(ModifiedModelBuilder)? updates]) =>
      (new ModifiedModelBuilder()..update(updates))._build();

  _$ModifiedModel._({this.product, this.requested, this.available}) : super._();

  @override
  ModifiedModel rebuild(void Function(ModifiedModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModifiedModelBuilder toBuilder() => new ModifiedModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModifiedModel &&
        product == other.product &&
        requested == other.requested &&
        available == other.available;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, requested.hashCode);
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ModifiedModel')
          ..add('product', product)
          ..add('requested', requested)
          ..add('available', available))
        .toString();
  }
}

class ModifiedModelBuilder
    implements Builder<ModifiedModel, ModifiedModelBuilder> {
  _$ModifiedModel? _$v;

  ProductModelBuilder? _product;
  ProductModelBuilder get product =>
      _$this._product ??= new ProductModelBuilder();
  set product(ProductModelBuilder? product) => _$this._product = product;

  int? _requested;
  int? get requested => _$this._requested;
  set requested(int? requested) => _$this._requested = requested;

  int? _available;
  int? get available => _$this._available;
  set available(int? available) => _$this._available = available;

  ModifiedModelBuilder();

  ModifiedModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _product = $v.product?.toBuilder();
      _requested = $v.requested;
      _available = $v.available;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModifiedModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ModifiedModel;
  }

  @override
  void update(void Function(ModifiedModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ModifiedModel build() => _build();

  _$ModifiedModel _build() {
    _$ModifiedModel _$result;
    try {
      _$result =
          _$v ??
          new _$ModifiedModel._(
            product: _product?.build(),
            requested: requested,
            available: available,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ModifiedModel',
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

class _$InformModel extends InformModel {
  @override
  final int? product;
  @override
  final int? count;

  factory _$InformModel([void Function(InformModelBuilder)? updates]) =>
      (new InformModelBuilder()..update(updates))._build();

  _$InformModel._({this.product, this.count}) : super._();

  @override
  InformModel rebuild(void Function(InformModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InformModelBuilder toBuilder() => new InformModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InformModel &&
        product == other.product &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InformModel')
          ..add('product', product)
          ..add('count', count))
        .toString();
  }
}

class InformModelBuilder implements Builder<InformModel, InformModelBuilder> {
  _$InformModel? _$v;

  int? _product;
  int? get product => _$this._product;
  set product(int? product) => _$this._product = product;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  InformModelBuilder();

  InformModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _product = $v.product;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InformModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InformModel;
  }

  @override
  void update(void Function(InformModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InformModel build() => _build();

  _$InformModel _build() {
    final _$result = _$v ?? new _$InformModel._(product: product, count: count);
    replace(_$result);
    return _$result;
  }
}

class _$OrderModel extends OrderModel {
  @override
  final int? id;
  @override
  final int? orderId;
  @override
  final String? client;
  @override
  final String? checkNumber;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? addressName;
  @override
  final String? payment;
  @override
  final String? actualOrderCreateTime;
  @override
  final String? deliveryTime;
  @override
  final String? acceptedAt;
  @override
  final String? collectedAt;
  @override
  final String? deliveredAt;
  @override
  final String? deliveryStartedAt;
  @override
  final String? status;
  @override
  final double? totalAmount;
  @override
  final int? itemsCount;
  @override
  final double? amountToPay;
  @override
  final double? deliveryPrice;
  @override
  final double? servicePrice;
  @override
  final double? promocodePrice;
  @override
  final String? fiscalCheck;
  @override
  final bool? isFirstOrder;
  @override
  final BuiltList<ProductModel>? orderThrought;
  @override
  final BuiltList<String>? orderItemsImages;

  factory _$OrderModel([void Function(OrderModelBuilder)? updates]) =>
      (new OrderModelBuilder()..update(updates))._build();

  _$OrderModel._({
    this.id,
    this.orderId,
    this.client,
    this.checkNumber,
    this.phone,
    this.address,
    this.addressName,
    this.payment,
    this.actualOrderCreateTime,
    this.deliveryTime,
    this.acceptedAt,
    this.collectedAt,
    this.deliveredAt,
    this.deliveryStartedAt,
    this.status,
    this.totalAmount,
    this.itemsCount,
    this.amountToPay,
    this.deliveryPrice,
    this.servicePrice,
    this.promocodePrice,
    this.fiscalCheck,
    this.isFirstOrder,
    this.orderThrought,
    this.orderItemsImages,
  }) : super._();

  @override
  OrderModel rebuild(void Function(OrderModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderModelBuilder toBuilder() => new OrderModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderModel &&
        id == other.id &&
        orderId == other.orderId &&
        client == other.client &&
        checkNumber == other.checkNumber &&
        phone == other.phone &&
        address == other.address &&
        addressName == other.addressName &&
        payment == other.payment &&
        actualOrderCreateTime == other.actualOrderCreateTime &&
        deliveryTime == other.deliveryTime &&
        acceptedAt == other.acceptedAt &&
        collectedAt == other.collectedAt &&
        deliveredAt == other.deliveredAt &&
        deliveryStartedAt == other.deliveryStartedAt &&
        status == other.status &&
        totalAmount == other.totalAmount &&
        itemsCount == other.itemsCount &&
        amountToPay == other.amountToPay &&
        deliveryPrice == other.deliveryPrice &&
        servicePrice == other.servicePrice &&
        promocodePrice == other.promocodePrice &&
        fiscalCheck == other.fiscalCheck &&
        isFirstOrder == other.isFirstOrder &&
        orderThrought == other.orderThrought &&
        orderItemsImages == other.orderItemsImages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, client.hashCode);
    _$hash = $jc(_$hash, checkNumber.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, addressName.hashCode);
    _$hash = $jc(_$hash, payment.hashCode);
    _$hash = $jc(_$hash, actualOrderCreateTime.hashCode);
    _$hash = $jc(_$hash, deliveryTime.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jc(_$hash, collectedAt.hashCode);
    _$hash = $jc(_$hash, deliveredAt.hashCode);
    _$hash = $jc(_$hash, deliveryStartedAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalAmount.hashCode);
    _$hash = $jc(_$hash, itemsCount.hashCode);
    _$hash = $jc(_$hash, amountToPay.hashCode);
    _$hash = $jc(_$hash, deliveryPrice.hashCode);
    _$hash = $jc(_$hash, servicePrice.hashCode);
    _$hash = $jc(_$hash, promocodePrice.hashCode);
    _$hash = $jc(_$hash, fiscalCheck.hashCode);
    _$hash = $jc(_$hash, isFirstOrder.hashCode);
    _$hash = $jc(_$hash, orderThrought.hashCode);
    _$hash = $jc(_$hash, orderItemsImages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderModel')
          ..add('id', id)
          ..add('orderId', orderId)
          ..add('client', client)
          ..add('checkNumber', checkNumber)
          ..add('phone', phone)
          ..add('address', address)
          ..add('addressName', addressName)
          ..add('payment', payment)
          ..add('actualOrderCreateTime', actualOrderCreateTime)
          ..add('deliveryTime', deliveryTime)
          ..add('acceptedAt', acceptedAt)
          ..add('collectedAt', collectedAt)
          ..add('deliveredAt', deliveredAt)
          ..add('deliveryStartedAt', deliveryStartedAt)
          ..add('status', status)
          ..add('totalAmount', totalAmount)
          ..add('itemsCount', itemsCount)
          ..add('amountToPay', amountToPay)
          ..add('deliveryPrice', deliveryPrice)
          ..add('servicePrice', servicePrice)
          ..add('promocodePrice', promocodePrice)
          ..add('fiscalCheck', fiscalCheck)
          ..add('isFirstOrder', isFirstOrder)
          ..add('orderThrought', orderThrought)
          ..add('orderItemsImages', orderItemsImages))
        .toString();
  }
}

class OrderModelBuilder implements Builder<OrderModel, OrderModelBuilder> {
  _$OrderModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _orderId;
  int? get orderId => _$this._orderId;
  set orderId(int? orderId) => _$this._orderId = orderId;

  String? _client;
  String? get client => _$this._client;
  set client(String? client) => _$this._client = client;

  String? _checkNumber;
  String? get checkNumber => _$this._checkNumber;
  set checkNumber(String? checkNumber) => _$this._checkNumber = checkNumber;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _addressName;
  String? get addressName => _$this._addressName;
  set addressName(String? addressName) => _$this._addressName = addressName;

  String? _payment;
  String? get payment => _$this._payment;
  set payment(String? payment) => _$this._payment = payment;

  String? _actualOrderCreateTime;
  String? get actualOrderCreateTime => _$this._actualOrderCreateTime;
  set actualOrderCreateTime(String? actualOrderCreateTime) =>
      _$this._actualOrderCreateTime = actualOrderCreateTime;

  String? _deliveryTime;
  String? get deliveryTime => _$this._deliveryTime;
  set deliveryTime(String? deliveryTime) => _$this._deliveryTime = deliveryTime;

  String? _acceptedAt;
  String? get acceptedAt => _$this._acceptedAt;
  set acceptedAt(String? acceptedAt) => _$this._acceptedAt = acceptedAt;

  String? _collectedAt;
  String? get collectedAt => _$this._collectedAt;
  set collectedAt(String? collectedAt) => _$this._collectedAt = collectedAt;

  String? _deliveredAt;
  String? get deliveredAt => _$this._deliveredAt;
  set deliveredAt(String? deliveredAt) => _$this._deliveredAt = deliveredAt;

  String? _deliveryStartedAt;
  String? get deliveryStartedAt => _$this._deliveryStartedAt;
  set deliveryStartedAt(String? deliveryStartedAt) =>
      _$this._deliveryStartedAt = deliveryStartedAt;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  double? _totalAmount;
  double? get totalAmount => _$this._totalAmount;
  set totalAmount(double? totalAmount) => _$this._totalAmount = totalAmount;

  int? _itemsCount;
  int? get itemsCount => _$this._itemsCount;
  set itemsCount(int? itemsCount) => _$this._itemsCount = itemsCount;

  double? _amountToPay;
  double? get amountToPay => _$this._amountToPay;
  set amountToPay(double? amountToPay) => _$this._amountToPay = amountToPay;

  double? _deliveryPrice;
  double? get deliveryPrice => _$this._deliveryPrice;
  set deliveryPrice(double? deliveryPrice) =>
      _$this._deliveryPrice = deliveryPrice;

  double? _servicePrice;
  double? get servicePrice => _$this._servicePrice;
  set servicePrice(double? servicePrice) => _$this._servicePrice = servicePrice;

  double? _promocodePrice;
  double? get promocodePrice => _$this._promocodePrice;
  set promocodePrice(double? promocodePrice) =>
      _$this._promocodePrice = promocodePrice;

  String? _fiscalCheck;
  String? get fiscalCheck => _$this._fiscalCheck;
  set fiscalCheck(String? fiscalCheck) => _$this._fiscalCheck = fiscalCheck;

  bool? _isFirstOrder;
  bool? get isFirstOrder => _$this._isFirstOrder;
  set isFirstOrder(bool? isFirstOrder) => _$this._isFirstOrder = isFirstOrder;

  ListBuilder<ProductModel>? _orderThrought;
  ListBuilder<ProductModel> get orderThrought =>
      _$this._orderThrought ??= new ListBuilder<ProductModel>();
  set orderThrought(ListBuilder<ProductModel>? orderThrought) =>
      _$this._orderThrought = orderThrought;

  ListBuilder<String>? _orderItemsImages;
  ListBuilder<String> get orderItemsImages =>
      _$this._orderItemsImages ??= new ListBuilder<String>();
  set orderItemsImages(ListBuilder<String>? orderItemsImages) =>
      _$this._orderItemsImages = orderItemsImages;

  OrderModelBuilder();

  OrderModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _orderId = $v.orderId;
      _client = $v.client;
      _checkNumber = $v.checkNumber;
      _phone = $v.phone;
      _address = $v.address;
      _addressName = $v.addressName;
      _payment = $v.payment;
      _actualOrderCreateTime = $v.actualOrderCreateTime;
      _deliveryTime = $v.deliveryTime;
      _acceptedAt = $v.acceptedAt;
      _collectedAt = $v.collectedAt;
      _deliveredAt = $v.deliveredAt;
      _deliveryStartedAt = $v.deliveryStartedAt;
      _status = $v.status;
      _totalAmount = $v.totalAmount;
      _itemsCount = $v.itemsCount;
      _amountToPay = $v.amountToPay;
      _deliveryPrice = $v.deliveryPrice;
      _servicePrice = $v.servicePrice;
      _promocodePrice = $v.promocodePrice;
      _fiscalCheck = $v.fiscalCheck;
      _isFirstOrder = $v.isFirstOrder;
      _orderThrought = $v.orderThrought?.toBuilder();
      _orderItemsImages = $v.orderItemsImages?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrderModel;
  }

  @override
  void update(void Function(OrderModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderModel build() => _build();

  _$OrderModel _build() {
    _$OrderModel _$result;
    try {
      _$result =
          _$v ??
          new _$OrderModel._(
            id: id,
            orderId: orderId,
            client: client,
            checkNumber: checkNumber,
            phone: phone,
            address: address,
            addressName: addressName,
            payment: payment,
            actualOrderCreateTime: actualOrderCreateTime,
            deliveryTime: deliveryTime,
            acceptedAt: acceptedAt,
            collectedAt: collectedAt,
            deliveredAt: deliveredAt,
            deliveryStartedAt: deliveryStartedAt,
            status: status,
            totalAmount: totalAmount,
            itemsCount: itemsCount,
            amountToPay: amountToPay,
            deliveryPrice: deliveryPrice,
            servicePrice: servicePrice,
            promocodePrice: promocodePrice,
            fiscalCheck: fiscalCheck,
            isFirstOrder: isFirstOrder,
            orderThrought: _orderThrought?.build(),
            orderItemsImages: _orderItemsImages?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orderThrought';
        _orderThrought?.build();
        _$failedField = 'orderItemsImages';
        _orderItemsImages?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'OrderModel',
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

class _$OrderReq extends OrderReq {
  @override
  final String? code;
  @override
  final double? totalAmount;
  @override
  final String? status;
  @override
  final BuiltList<ProductModel>? products;
  @override
  final String? comment;
  @override
  final double? amountToPay;
  @override
  final double? deliveryPrice;
  @override
  final double? expresPrice;
  @override
  final double? servicePrice;
  @override
  final double? minimumPrice;
  @override
  final double? fromBalance;
  @override
  final double? tipsPrice;
  @override
  final String? estimatedOrderTime;
  @override
  final int? payment;
  @override
  final int? address;
  @override
  final int? promo;
  @override
  final bool? isAdditional;
  @override
  final int? orderToAdd;
  @override
  final int? category;

  factory _$OrderReq([void Function(OrderReqBuilder)? updates]) =>
      (new OrderReqBuilder()..update(updates))._build();

  _$OrderReq._({
    this.code,
    this.totalAmount,
    this.status,
    this.products,
    this.comment,
    this.amountToPay,
    this.deliveryPrice,
    this.expresPrice,
    this.servicePrice,
    this.minimumPrice,
    this.fromBalance,
    this.tipsPrice,
    this.estimatedOrderTime,
    this.payment,
    this.address,
    this.promo,
    this.isAdditional,
    this.orderToAdd,
    this.category,
  }) : super._();

  @override
  OrderReq rebuild(void Function(OrderReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderReqBuilder toBuilder() => new OrderReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderReq &&
        code == other.code &&
        totalAmount == other.totalAmount &&
        status == other.status &&
        products == other.products &&
        comment == other.comment &&
        amountToPay == other.amountToPay &&
        deliveryPrice == other.deliveryPrice &&
        expresPrice == other.expresPrice &&
        servicePrice == other.servicePrice &&
        minimumPrice == other.minimumPrice &&
        fromBalance == other.fromBalance &&
        tipsPrice == other.tipsPrice &&
        estimatedOrderTime == other.estimatedOrderTime &&
        payment == other.payment &&
        address == other.address &&
        promo == other.promo &&
        isAdditional == other.isAdditional &&
        orderToAdd == other.orderToAdd &&
        category == other.category;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, totalAmount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, amountToPay.hashCode);
    _$hash = $jc(_$hash, deliveryPrice.hashCode);
    _$hash = $jc(_$hash, expresPrice.hashCode);
    _$hash = $jc(_$hash, servicePrice.hashCode);
    _$hash = $jc(_$hash, minimumPrice.hashCode);
    _$hash = $jc(_$hash, fromBalance.hashCode);
    _$hash = $jc(_$hash, tipsPrice.hashCode);
    _$hash = $jc(_$hash, estimatedOrderTime.hashCode);
    _$hash = $jc(_$hash, payment.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, promo.hashCode);
    _$hash = $jc(_$hash, isAdditional.hashCode);
    _$hash = $jc(_$hash, orderToAdd.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderReq')
          ..add('code', code)
          ..add('totalAmount', totalAmount)
          ..add('status', status)
          ..add('products', products)
          ..add('comment', comment)
          ..add('amountToPay', amountToPay)
          ..add('deliveryPrice', deliveryPrice)
          ..add('expresPrice', expresPrice)
          ..add('servicePrice', servicePrice)
          ..add('minimumPrice', minimumPrice)
          ..add('fromBalance', fromBalance)
          ..add('tipsPrice', tipsPrice)
          ..add('estimatedOrderTime', estimatedOrderTime)
          ..add('payment', payment)
          ..add('address', address)
          ..add('promo', promo)
          ..add('isAdditional', isAdditional)
          ..add('orderToAdd', orderToAdd)
          ..add('category', category))
        .toString();
  }
}

class OrderReqBuilder implements Builder<OrderReq, OrderReqBuilder> {
  _$OrderReq? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  double? _totalAmount;
  double? get totalAmount => _$this._totalAmount;
  set totalAmount(double? totalAmount) => _$this._totalAmount = totalAmount;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  ListBuilder<ProductModel>? _products;
  ListBuilder<ProductModel> get products =>
      _$this._products ??= new ListBuilder<ProductModel>();
  set products(ListBuilder<ProductModel>? products) =>
      _$this._products = products;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  double? _amountToPay;
  double? get amountToPay => _$this._amountToPay;
  set amountToPay(double? amountToPay) => _$this._amountToPay = amountToPay;

  double? _deliveryPrice;
  double? get deliveryPrice => _$this._deliveryPrice;
  set deliveryPrice(double? deliveryPrice) =>
      _$this._deliveryPrice = deliveryPrice;

  double? _expresPrice;
  double? get expresPrice => _$this._expresPrice;
  set expresPrice(double? expresPrice) => _$this._expresPrice = expresPrice;

  double? _servicePrice;
  double? get servicePrice => _$this._servicePrice;
  set servicePrice(double? servicePrice) => _$this._servicePrice = servicePrice;

  double? _minimumPrice;
  double? get minimumPrice => _$this._minimumPrice;
  set minimumPrice(double? minimumPrice) => _$this._minimumPrice = minimumPrice;

  double? _fromBalance;
  double? get fromBalance => _$this._fromBalance;
  set fromBalance(double? fromBalance) => _$this._fromBalance = fromBalance;

  double? _tipsPrice;
  double? get tipsPrice => _$this._tipsPrice;
  set tipsPrice(double? tipsPrice) => _$this._tipsPrice = tipsPrice;

  String? _estimatedOrderTime;
  String? get estimatedOrderTime => _$this._estimatedOrderTime;
  set estimatedOrderTime(String? estimatedOrderTime) =>
      _$this._estimatedOrderTime = estimatedOrderTime;

  int? _payment;
  int? get payment => _$this._payment;
  set payment(int? payment) => _$this._payment = payment;

  int? _address;
  int? get address => _$this._address;
  set address(int? address) => _$this._address = address;

  int? _promo;
  int? get promo => _$this._promo;
  set promo(int? promo) => _$this._promo = promo;

  bool? _isAdditional;
  bool? get isAdditional => _$this._isAdditional;
  set isAdditional(bool? isAdditional) => _$this._isAdditional = isAdditional;

  int? _orderToAdd;
  int? get orderToAdd => _$this._orderToAdd;
  set orderToAdd(int? orderToAdd) => _$this._orderToAdd = orderToAdd;

  int? _category;
  int? get category => _$this._category;
  set category(int? category) => _$this._category = category;

  OrderReqBuilder();

  OrderReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _totalAmount = $v.totalAmount;
      _status = $v.status;
      _products = $v.products?.toBuilder();
      _comment = $v.comment;
      _amountToPay = $v.amountToPay;
      _deliveryPrice = $v.deliveryPrice;
      _expresPrice = $v.expresPrice;
      _servicePrice = $v.servicePrice;
      _minimumPrice = $v.minimumPrice;
      _fromBalance = $v.fromBalance;
      _tipsPrice = $v.tipsPrice;
      _estimatedOrderTime = $v.estimatedOrderTime;
      _payment = $v.payment;
      _address = $v.address;
      _promo = $v.promo;
      _isAdditional = $v.isAdditional;
      _orderToAdd = $v.orderToAdd;
      _category = $v.category;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderReq other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrderReq;
  }

  @override
  void update(void Function(OrderReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderReq build() => _build();

  _$OrderReq _build() {
    _$OrderReq _$result;
    try {
      _$result =
          _$v ??
          new _$OrderReq._(
            code: code,
            totalAmount: totalAmount,
            status: status,
            products: _products?.build(),
            comment: comment,
            amountToPay: amountToPay,
            deliveryPrice: deliveryPrice,
            expresPrice: expresPrice,
            servicePrice: servicePrice,
            minimumPrice: minimumPrice,
            fromBalance: fromBalance,
            tipsPrice: tipsPrice,
            estimatedOrderTime: estimatedOrderTime,
            payment: payment,
            address: address,
            promo: promo,
            isAdditional: isAdditional,
            orderToAdd: orderToAdd,
            category: category,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        _products?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'OrderReq',
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

class _$Categories extends Categories {
  @override
  final String? categoryName;
  @override
  final String? icon;
  @override
  final BuiltList<SubCategories>? subCategories;

  factory _$Categories([void Function(CategoriesBuilder)? updates]) =>
      (new CategoriesBuilder()..update(updates))._build();

  _$Categories._({this.categoryName, this.icon, this.subCategories})
    : super._();

  @override
  Categories rebuild(void Function(CategoriesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoriesBuilder toBuilder() => new CategoriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Categories &&
        categoryName == other.categoryName &&
        icon == other.icon &&
        subCategories == other.subCategories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categoryName.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, subCategories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Categories')
          ..add('categoryName', categoryName)
          ..add('icon', icon)
          ..add('subCategories', subCategories))
        .toString();
  }
}

class CategoriesBuilder implements Builder<Categories, CategoriesBuilder> {
  _$Categories? _$v;

  String? _categoryName;
  String? get categoryName => _$this._categoryName;
  set categoryName(String? categoryName) => _$this._categoryName = categoryName;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  ListBuilder<SubCategories>? _subCategories;
  ListBuilder<SubCategories> get subCategories =>
      _$this._subCategories ??= new ListBuilder<SubCategories>();
  set subCategories(ListBuilder<SubCategories>? subCategories) =>
      _$this._subCategories = subCategories;

  CategoriesBuilder();

  CategoriesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryName = $v.categoryName;
      _icon = $v.icon;
      _subCategories = $v.subCategories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Categories other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Categories;
  }

  @override
  void update(void Function(CategoriesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Categories build() => _build();

  _$Categories _build() {
    _$Categories _$result;
    try {
      _$result =
          _$v ??
          new _$Categories._(
            categoryName: categoryName,
            icon: icon,
            subCategories: _subCategories?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subCategories';
        _subCategories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'Categories',
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

class _$SubCategories extends SubCategories {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? image;

  factory _$SubCategories([void Function(SubCategoriesBuilder)? updates]) =>
      (new SubCategoriesBuilder()..update(updates))._build();

  _$SubCategories._({this.id, this.name, this.image}) : super._();

  @override
  SubCategories rebuild(void Function(SubCategoriesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubCategoriesBuilder toBuilder() => new SubCategoriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubCategories &&
        id == other.id &&
        name == other.name &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubCategories')
          ..add('id', id)
          ..add('name', name)
          ..add('image', image))
        .toString();
  }
}

class SubCategoriesBuilder
    implements Builder<SubCategories, SubCategoriesBuilder> {
  _$SubCategories? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  SubCategoriesBuilder();

  SubCategoriesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubCategories other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubCategories;
  }

  @override
  void update(void Function(SubCategoriesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubCategories build() => _build();

  _$SubCategories _build() {
    final _$result =
        _$v ?? new _$SubCategories._(id: id, name: name, image: image);
    replace(_$result);
    return _$result;
  }
}

class _$OrderStatusRes extends OrderStatusRes {
  @override
  final String? status;
  @override
  final String? address;
  @override
  final String? checkNumber;
  @override
  final String? actualOrderCreateTime;
  @override
  final String? deliveryTime;
  @override
  final String? deliveryStartedAt;
  @override
  final String? deliveredAt;
  @override
  final String? collectedAt;
  @override
  final String? acceptedAt;

  factory _$OrderStatusRes([void Function(OrderStatusResBuilder)? updates]) =>
      (new OrderStatusResBuilder()..update(updates))._build();

  _$OrderStatusRes._({
    this.status,
    this.address,
    this.checkNumber,
    this.actualOrderCreateTime,
    this.deliveryTime,
    this.deliveryStartedAt,
    this.deliveredAt,
    this.collectedAt,
    this.acceptedAt,
  }) : super._();

  @override
  OrderStatusRes rebuild(void Function(OrderStatusResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderStatusResBuilder toBuilder() =>
      new OrderStatusResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderStatusRes &&
        status == other.status &&
        address == other.address &&
        checkNumber == other.checkNumber &&
        actualOrderCreateTime == other.actualOrderCreateTime &&
        deliveryTime == other.deliveryTime &&
        deliveryStartedAt == other.deliveryStartedAt &&
        deliveredAt == other.deliveredAt &&
        collectedAt == other.collectedAt &&
        acceptedAt == other.acceptedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, checkNumber.hashCode);
    _$hash = $jc(_$hash, actualOrderCreateTime.hashCode);
    _$hash = $jc(_$hash, deliveryTime.hashCode);
    _$hash = $jc(_$hash, deliveryStartedAt.hashCode);
    _$hash = $jc(_$hash, deliveredAt.hashCode);
    _$hash = $jc(_$hash, collectedAt.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderStatusRes')
          ..add('status', status)
          ..add('address', address)
          ..add('checkNumber', checkNumber)
          ..add('actualOrderCreateTime', actualOrderCreateTime)
          ..add('deliveryTime', deliveryTime)
          ..add('deliveryStartedAt', deliveryStartedAt)
          ..add('deliveredAt', deliveredAt)
          ..add('collectedAt', collectedAt)
          ..add('acceptedAt', acceptedAt))
        .toString();
  }
}

class OrderStatusResBuilder
    implements Builder<OrderStatusRes, OrderStatusResBuilder> {
  _$OrderStatusRes? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _checkNumber;
  String? get checkNumber => _$this._checkNumber;
  set checkNumber(String? checkNumber) => _$this._checkNumber = checkNumber;

  String? _actualOrderCreateTime;
  String? get actualOrderCreateTime => _$this._actualOrderCreateTime;
  set actualOrderCreateTime(String? actualOrderCreateTime) =>
      _$this._actualOrderCreateTime = actualOrderCreateTime;

  String? _deliveryTime;
  String? get deliveryTime => _$this._deliveryTime;
  set deliveryTime(String? deliveryTime) => _$this._deliveryTime = deliveryTime;

  String? _deliveryStartedAt;
  String? get deliveryStartedAt => _$this._deliveryStartedAt;
  set deliveryStartedAt(String? deliveryStartedAt) =>
      _$this._deliveryStartedAt = deliveryStartedAt;

  String? _deliveredAt;
  String? get deliveredAt => _$this._deliveredAt;
  set deliveredAt(String? deliveredAt) => _$this._deliveredAt = deliveredAt;

  String? _collectedAt;
  String? get collectedAt => _$this._collectedAt;
  set collectedAt(String? collectedAt) => _$this._collectedAt = collectedAt;

  String? _acceptedAt;
  String? get acceptedAt => _$this._acceptedAt;
  set acceptedAt(String? acceptedAt) => _$this._acceptedAt = acceptedAt;

  OrderStatusResBuilder();

  OrderStatusResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _address = $v.address;
      _checkNumber = $v.checkNumber;
      _actualOrderCreateTime = $v.actualOrderCreateTime;
      _deliveryTime = $v.deliveryTime;
      _deliveryStartedAt = $v.deliveryStartedAt;
      _deliveredAt = $v.deliveredAt;
      _collectedAt = $v.collectedAt;
      _acceptedAt = $v.acceptedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderStatusRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrderStatusRes;
  }

  @override
  void update(void Function(OrderStatusResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderStatusRes build() => _build();

  _$OrderStatusRes _build() {
    final _$result =
        _$v ??
        new _$OrderStatusRes._(
          status: status,
          address: address,
          checkNumber: checkNumber,
          actualOrderCreateTime: actualOrderCreateTime,
          deliveryTime: deliveryTime,
          deliveryStartedAt: deliveryStartedAt,
          deliveredAt: deliveredAt,
          collectedAt: collectedAt,
          acceptedAt: acceptedAt,
        );
    replace(_$result);
    return _$result;
  }
}

class _$PlannedOrderListModel extends PlannedOrderListModel {
  @override
  final int? page;
  @override
  final int? count;
  @override
  final int? totalPages;
  @override
  final BuiltList<PlannedOrderModel>? results;

  factory _$PlannedOrderListModel([
    void Function(PlannedOrderListModelBuilder)? updates,
  ]) => (new PlannedOrderListModelBuilder()..update(updates))._build();

  _$PlannedOrderListModel._({
    this.page,
    this.count,
    this.totalPages,
    this.results,
  }) : super._();

  @override
  PlannedOrderListModel rebuild(
    void Function(PlannedOrderListModelBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PlannedOrderListModelBuilder toBuilder() =>
      new PlannedOrderListModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlannedOrderListModel &&
        page == other.page &&
        count == other.count &&
        totalPages == other.totalPages &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlannedOrderListModel')
          ..add('page', page)
          ..add('count', count)
          ..add('totalPages', totalPages)
          ..add('results', results))
        .toString();
  }
}

class PlannedOrderListModelBuilder
    implements Builder<PlannedOrderListModel, PlannedOrderListModelBuilder> {
  _$PlannedOrderListModel? _$v;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<PlannedOrderModel>? _results;
  ListBuilder<PlannedOrderModel> get results =>
      _$this._results ??= new ListBuilder<PlannedOrderModel>();
  set results(ListBuilder<PlannedOrderModel>? results) =>
      _$this._results = results;

  PlannedOrderListModelBuilder();

  PlannedOrderListModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _page = $v.page;
      _count = $v.count;
      _totalPages = $v.totalPages;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlannedOrderListModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PlannedOrderListModel;
  }

  @override
  void update(void Function(PlannedOrderListModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlannedOrderListModel build() => _build();

  _$PlannedOrderListModel _build() {
    _$PlannedOrderListModel _$result;
    try {
      _$result =
          _$v ??
          new _$PlannedOrderListModel._(
            page: page,
            count: count,
            totalPages: totalPages,
            results: _results?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'PlannedOrderListModel',
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

class _$PlannedOrderModel extends PlannedOrderModel {
  @override
  final int? id;
  @override
  final BuiltList<ProductModel>? items;
  @override
  final BuiltList<Schedules>? schedules;
  @override
  final String? addressName;
  @override
  final String? addressTitle;
  @override
  final String? paymentName;
  @override
  final String? title;
  @override
  final String? status;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  final int? client;
  @override
  final int? paymentType;
  @override
  final int? address;
  @override
  final double? totalAmountValue;
  @override
  final int? itemsCount;
  @override
  final String? time;
  @override
  final String? dayOfWeeks;
  @override
  final BuiltList<String>? images;
  @override
  final BuiltList<DayModel>? weeks;

  factory _$PlannedOrderModel([
    void Function(PlannedOrderModelBuilder)? updates,
  ]) => (new PlannedOrderModelBuilder()..update(updates))._build();

  _$PlannedOrderModel._({
    this.id,
    this.items,
    this.schedules,
    this.addressName,
    this.addressTitle,
    this.paymentName,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.client,
    this.paymentType,
    this.address,
    this.totalAmountValue,
    this.itemsCount,
    this.time,
    this.dayOfWeeks,
    this.images,
    this.weeks,
  }) : super._();

  @override
  PlannedOrderModel rebuild(void Function(PlannedOrderModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlannedOrderModelBuilder toBuilder() =>
      new PlannedOrderModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlannedOrderModel &&
        id == other.id &&
        items == other.items &&
        schedules == other.schedules &&
        addressName == other.addressName &&
        addressTitle == other.addressTitle &&
        paymentName == other.paymentName &&
        title == other.title &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        client == other.client &&
        paymentType == other.paymentType &&
        address == other.address &&
        totalAmountValue == other.totalAmountValue &&
        itemsCount == other.itemsCount &&
        time == other.time &&
        dayOfWeeks == other.dayOfWeeks &&
        images == other.images &&
        weeks == other.weeks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, schedules.hashCode);
    _$hash = $jc(_$hash, addressName.hashCode);
    _$hash = $jc(_$hash, addressTitle.hashCode);
    _$hash = $jc(_$hash, paymentName.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, client.hashCode);
    _$hash = $jc(_$hash, paymentType.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, totalAmountValue.hashCode);
    _$hash = $jc(_$hash, itemsCount.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jc(_$hash, dayOfWeeks.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, weeks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlannedOrderModel')
          ..add('id', id)
          ..add('items', items)
          ..add('schedules', schedules)
          ..add('addressName', addressName)
          ..add('addressTitle', addressTitle)
          ..add('paymentName', paymentName)
          ..add('title', title)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('client', client)
          ..add('paymentType', paymentType)
          ..add('address', address)
          ..add('totalAmountValue', totalAmountValue)
          ..add('itemsCount', itemsCount)
          ..add('time', time)
          ..add('dayOfWeeks', dayOfWeeks)
          ..add('images', images)
          ..add('weeks', weeks))
        .toString();
  }
}

class PlannedOrderModelBuilder
    implements Builder<PlannedOrderModel, PlannedOrderModelBuilder> {
  _$PlannedOrderModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ListBuilder<ProductModel>? _items;
  ListBuilder<ProductModel> get items =>
      _$this._items ??= new ListBuilder<ProductModel>();
  set items(ListBuilder<ProductModel>? items) => _$this._items = items;

  ListBuilder<Schedules>? _schedules;
  ListBuilder<Schedules> get schedules =>
      _$this._schedules ??= new ListBuilder<Schedules>();
  set schedules(ListBuilder<Schedules>? schedules) =>
      _$this._schedules = schedules;

  String? _addressName;
  String? get addressName => _$this._addressName;
  set addressName(String? addressName) => _$this._addressName = addressName;

  String? _addressTitle;
  String? get addressTitle => _$this._addressTitle;
  set addressTitle(String? addressTitle) => _$this._addressTitle = addressTitle;

  String? _paymentName;
  String? get paymentName => _$this._paymentName;
  set paymentName(String? paymentName) => _$this._paymentName = paymentName;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  int? _client;
  int? get client => _$this._client;
  set client(int? client) => _$this._client = client;

  int? _paymentType;
  int? get paymentType => _$this._paymentType;
  set paymentType(int? paymentType) => _$this._paymentType = paymentType;

  int? _address;
  int? get address => _$this._address;
  set address(int? address) => _$this._address = address;

  double? _totalAmountValue;
  double? get totalAmountValue => _$this._totalAmountValue;
  set totalAmountValue(double? totalAmountValue) =>
      _$this._totalAmountValue = totalAmountValue;

  int? _itemsCount;
  int? get itemsCount => _$this._itemsCount;
  set itemsCount(int? itemsCount) => _$this._itemsCount = itemsCount;

  String? _time;
  String? get time => _$this._time;
  set time(String? time) => _$this._time = time;

  String? _dayOfWeeks;
  String? get dayOfWeeks => _$this._dayOfWeeks;
  set dayOfWeeks(String? dayOfWeeks) => _$this._dayOfWeeks = dayOfWeeks;

  ListBuilder<String>? _images;
  ListBuilder<String> get images =>
      _$this._images ??= new ListBuilder<String>();
  set images(ListBuilder<String>? images) => _$this._images = images;

  ListBuilder<DayModel>? _weeks;
  ListBuilder<DayModel> get weeks =>
      _$this._weeks ??= new ListBuilder<DayModel>();
  set weeks(ListBuilder<DayModel>? weeks) => _$this._weeks = weeks;

  PlannedOrderModelBuilder();

  PlannedOrderModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _items = $v.items?.toBuilder();
      _schedules = $v.schedules?.toBuilder();
      _addressName = $v.addressName;
      _addressTitle = $v.addressTitle;
      _paymentName = $v.paymentName;
      _title = $v.title;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _client = $v.client;
      _paymentType = $v.paymentType;
      _address = $v.address;
      _totalAmountValue = $v.totalAmountValue;
      _itemsCount = $v.itemsCount;
      _time = $v.time;
      _dayOfWeeks = $v.dayOfWeeks;
      _images = $v.images?.toBuilder();
      _weeks = $v.weeks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlannedOrderModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PlannedOrderModel;
  }

  @override
  void update(void Function(PlannedOrderModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlannedOrderModel build() => _build();

  _$PlannedOrderModel _build() {
    _$PlannedOrderModel _$result;
    try {
      _$result =
          _$v ??
          new _$PlannedOrderModel._(
            id: id,
            items: _items?.build(),
            schedules: _schedules?.build(),
            addressName: addressName,
            addressTitle: addressTitle,
            paymentName: paymentName,
            title: title,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            client: client,
            paymentType: paymentType,
            address: address,
            totalAmountValue: totalAmountValue,
            itemsCount: itemsCount,
            time: time,
            dayOfWeeks: dayOfWeeks,
            images: _images?.build(),
            weeks: _weeks?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
        _$failedField = 'schedules';
        _schedules?.build();

        _$failedField = 'images';
        _images?.build();
        _$failedField = 'weeks';
        _weeks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'PlannedOrderModel',
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

class _$DayModel extends DayModel {
  @override
  final String? day;
  @override
  final bool? isActive;

  factory _$DayModel([void Function(DayModelBuilder)? updates]) =>
      (new DayModelBuilder()..update(updates))._build();

  _$DayModel._({this.day, this.isActive}) : super._();

  @override
  DayModel rebuild(void Function(DayModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DayModelBuilder toBuilder() => new DayModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DayModel && day == other.day && isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, day.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DayModel')
          ..add('day', day)
          ..add('isActive', isActive))
        .toString();
  }
}

class DayModelBuilder implements Builder<DayModel, DayModelBuilder> {
  _$DayModel? _$v;

  String? _day;
  String? get day => _$this._day;
  set day(String? day) => _$this._day = day;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DayModelBuilder();

  DayModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _day = $v.day;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DayModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DayModel;
  }

  @override
  void update(void Function(DayModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DayModel build() => _build();

  _$DayModel _build() {
    final _$result = _$v ?? new _$DayModel._(day: day, isActive: isActive);
    replace(_$result);
    return _$result;
  }
}

class _$Schedules extends Schedules {
  @override
  final int? id;
  @override
  final int? dayOfWeek;
  @override
  final String? time;
  @override
  final bool? isActive;

  factory _$Schedules([void Function(SchedulesBuilder)? updates]) =>
      (new SchedulesBuilder()..update(updates))._build();

  _$Schedules._({this.id, this.dayOfWeek, this.time, this.isActive})
    : super._();

  @override
  Schedules rebuild(void Function(SchedulesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SchedulesBuilder toBuilder() => new SchedulesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Schedules &&
        id == other.id &&
        dayOfWeek == other.dayOfWeek &&
        time == other.time &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Schedules')
          ..add('id', id)
          ..add('dayOfWeek', dayOfWeek)
          ..add('time', time)
          ..add('isActive', isActive))
        .toString();
  }
}

class SchedulesBuilder implements Builder<Schedules, SchedulesBuilder> {
  _$Schedules? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

  String? _time;
  String? get time => _$this._time;
  set time(String? time) => _$this._time = time;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  SchedulesBuilder();

  SchedulesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _dayOfWeek = $v.dayOfWeek;
      _time = $v.time;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Schedules other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Schedules;
  }

  @override
  void update(void Function(SchedulesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Schedules build() => _build();

  _$Schedules _build() {
    final _$result =
        _$v ??
        new _$Schedules._(
          id: id,
          dayOfWeek: dayOfWeek,
          time: time,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

class _$InformRes extends InformRes {
  @override
  final int? id;
  @override
  final ProductModel? product;
  @override
  final int? count;
  @override
  final bool? isSent;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  factory _$InformRes([void Function(InformResBuilder)? updates]) =>
      (new InformResBuilder()..update(updates))._build();

  _$InformRes._({
    this.id,
    this.product,
    this.count,
    this.isSent,
    this.createdAt,
    this.updatedAt,
  }) : super._();

  @override
  InformRes rebuild(void Function(InformResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InformResBuilder toBuilder() => new InformResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InformRes &&
        id == other.id &&
        product == other.product &&
        count == other.count &&
        isSent == other.isSent &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, isSent.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InformRes')
          ..add('id', id)
          ..add('product', product)
          ..add('count', count)
          ..add('isSent', isSent)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class InformResBuilder implements Builder<InformRes, InformResBuilder> {
  _$InformRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ProductModelBuilder? _product;
  ProductModelBuilder get product =>
      _$this._product ??= new ProductModelBuilder();
  set product(ProductModelBuilder? product) => _$this._product = product;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _isSent;
  bool? get isSent => _$this._isSent;
  set isSent(bool? isSent) => _$this._isSent = isSent;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  InformResBuilder();

  InformResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _product = $v.product?.toBuilder();
      _count = $v.count;
      _isSent = $v.isSent;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InformRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InformRes;
  }

  @override
  void update(void Function(InformResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InformRes build() => _build();

  _$InformRes _build() {
    _$InformRes _$result;
    try {
      _$result =
          _$v ??
          new _$InformRes._(
            id: id,
            product: _product?.build(),
            count: count,
            isSent: isSent,
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'InformRes',
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

class _$Inform extends Inform {
  @override
  final int? page;
  @override
  final int? count;
  @override
  final int? totalPages;
  @override
  final BuiltList<InformRes>? results;

  factory _$Inform([void Function(InformBuilder)? updates]) =>
      (new InformBuilder()..update(updates))._build();

  _$Inform._({this.page, this.count, this.totalPages, this.results})
    : super._();

  @override
  Inform rebuild(void Function(InformBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InformBuilder toBuilder() => new InformBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Inform &&
        page == other.page &&
        count == other.count &&
        totalPages == other.totalPages &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Inform')
          ..add('page', page)
          ..add('count', count)
          ..add('totalPages', totalPages)
          ..add('results', results))
        .toString();
  }
}

class InformBuilder implements Builder<Inform, InformBuilder> {
  _$Inform? _$v;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<InformRes>? _results;
  ListBuilder<InformRes> get results =>
      _$this._results ??= new ListBuilder<InformRes>();
  set results(ListBuilder<InformRes>? results) => _$this._results = results;

  InformBuilder();

  InformBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _page = $v.page;
      _count = $v.count;
      _totalPages = $v.totalPages;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Inform other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Inform;
  }

  @override
  void update(void Function(InformBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Inform build() => _build();

  _$Inform _build() {
    _$Inform _$result;
    try {
      _$result =
          _$v ??
          new _$Inform._(
            page: page,
            count: count,
            totalPages: totalPages,
            results: _results?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'Inform',
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

class _$InformCreateRes extends InformCreateRes {
  @override
  final int? id;
  @override
  final int? product;
  @override
  final int? count;
  @override
  final bool? isSent;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  final int? client;

  factory _$InformCreateRes([void Function(InformCreateResBuilder)? updates]) =>
      (new InformCreateResBuilder()..update(updates))._build();

  _$InformCreateRes._({
    this.id,
    this.product,
    this.count,
    this.isSent,
    this.createdAt,
    this.updatedAt,
    this.client,
  }) : super._();

  @override
  InformCreateRes rebuild(void Function(InformCreateResBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InformCreateResBuilder toBuilder() =>
      new InformCreateResBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InformCreateRes &&
        id == other.id &&
        product == other.product &&
        count == other.count &&
        isSent == other.isSent &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        client == other.client;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, isSent.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, client.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InformCreateRes')
          ..add('id', id)
          ..add('product', product)
          ..add('count', count)
          ..add('isSent', isSent)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('client', client))
        .toString();
  }
}

class InformCreateResBuilder
    implements Builder<InformCreateRes, InformCreateResBuilder> {
  _$InformCreateRes? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _product;
  int? get product => _$this._product;
  set product(int? product) => _$this._product = product;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _isSent;
  bool? get isSent => _$this._isSent;
  set isSent(bool? isSent) => _$this._isSent = isSent;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  int? _client;
  int? get client => _$this._client;
  set client(int? client) => _$this._client = client;

  InformCreateResBuilder();

  InformCreateResBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _product = $v.product;
      _count = $v.count;
      _isSent = $v.isSent;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _client = $v.client;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InformCreateRes other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InformCreateRes;
  }

  @override
  void update(void Function(InformCreateResBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InformCreateRes build() => _build();

  _$InformCreateRes _build() {
    final _$result =
        _$v ??
        new _$InformCreateRes._(
          id: id,
          product: product,
          count: count,
          isSent: isSent,
          createdAt: createdAt,
          updatedAt: updatedAt,
          client: client,
        );
    replace(_$result);
    return _$result;
  }
}

class _$ProductCatalogResponse extends ProductCatalogResponse {
  @override
  final int? count;
  @override
  final bool? next;
  @override
  final bool? previous;
  @override
  final BuiltList<ProductCategory>? results;

  factory _$ProductCatalogResponse([
    void Function(ProductCatalogResponseBuilder)? updates,
  ]) => (new ProductCatalogResponseBuilder()..update(updates))._build();

  _$ProductCatalogResponse._({
    this.count,
    this.next,
    this.previous,
    this.results,
  }) : super._();

  @override
  ProductCatalogResponse rebuild(
    void Function(ProductCatalogResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductCatalogResponseBuilder toBuilder() =>
      new ProductCatalogResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductCatalogResponse &&
        count == other.count &&
        next == other.next &&
        previous == other.previous &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, next.hashCode);
    _$hash = $jc(_$hash, previous.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductCatalogResponse')
          ..add('count', count)
          ..add('next', next)
          ..add('previous', previous)
          ..add('results', results))
        .toString();
  }
}

class ProductCatalogResponseBuilder
    implements Builder<ProductCatalogResponse, ProductCatalogResponseBuilder> {
  _$ProductCatalogResponse? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _next;
  bool? get next => _$this._next;
  set next(bool? next) => _$this._next = next;

  bool? _previous;
  bool? get previous => _$this._previous;
  set previous(bool? previous) => _$this._previous = previous;

  ListBuilder<ProductCategory>? _results;
  ListBuilder<ProductCategory> get results =>
      _$this._results ??= new ListBuilder<ProductCategory>();
  set results(ListBuilder<ProductCategory>? results) =>
      _$this._results = results;

  ProductCatalogResponseBuilder();

  ProductCatalogResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _next = $v.next;
      _previous = $v.previous;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductCatalogResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductCatalogResponse;
  }

  @override
  void update(void Function(ProductCatalogResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductCatalogResponse build() => _build();

  _$ProductCatalogResponse _build() {
    _$ProductCatalogResponse _$result;
    try {
      _$result =
          _$v ??
          new _$ProductCatalogResponse._(
            count: count,
            next: next,
            previous: previous,
            results: _results?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ProductCatalogResponse',
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

class _$ProductModelResponse extends ProductModelResponse {
  @override
  final int? page;
  @override
  final int? count;
  @override
  final int? totalPages;
  @override
  final BuiltList<ProductModel>? results;

  factory _$ProductModelResponse([
    void Function(ProductModelResponseBuilder)? updates,
  ]) => (new ProductModelResponseBuilder()..update(updates))._build();

  _$ProductModelResponse._({
    this.page,
    this.count,
    this.totalPages,
    this.results,
  }) : super._();

  @override
  ProductModelResponse rebuild(
    void Function(ProductModelResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductModelResponseBuilder toBuilder() =>
      new ProductModelResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductModelResponse &&
        page == other.page &&
        count == other.count &&
        totalPages == other.totalPages &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductModelResponse')
          ..add('page', page)
          ..add('count', count)
          ..add('totalPages', totalPages)
          ..add('results', results))
        .toString();
  }
}

class ProductModelResponseBuilder
    implements Builder<ProductModelResponse, ProductModelResponseBuilder> {
  _$ProductModelResponse? _$v;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  ListBuilder<ProductModel>? _results;
  ListBuilder<ProductModel> get results =>
      _$this._results ??= new ListBuilder<ProductModel>();
  set results(ListBuilder<ProductModel>? results) => _$this._results = results;

  ProductModelResponseBuilder();

  ProductModelResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _page = $v.page;
      _count = $v.count;
      _totalPages = $v.totalPages;
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductModelResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductModelResponse;
  }

  @override
  void update(void Function(ProductModelResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductModelResponse build() => _build();

  _$ProductModelResponse _build() {
    _$ProductModelResponse _$result;
    try {
      _$result =
          _$v ??
          new _$ProductModelResponse._(
            page: page,
            count: count,
            totalPages: totalPages,
            results: _results?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ProductModelResponse',
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

class _$ProductCategory extends ProductCategory {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? image;
  @override
  final int? category;
  @override
  final BuiltList<ProductModel>? products;
  @override
  final int? productCount;

  factory _$ProductCategory([void Function(ProductCategoryBuilder)? updates]) =>
      (new ProductCategoryBuilder()..update(updates))._build();

  _$ProductCategory._({
    this.id,
    this.title,
    this.image,
    this.category,
    this.products,
    this.productCount,
  }) : super._();

  @override
  ProductCategory rebuild(void Function(ProductCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductCategoryBuilder toBuilder() =>
      new ProductCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductCategory &&
        id == other.id &&
        title == other.title &&
        image == other.image &&
        category == other.category &&
        products == other.products &&
        productCount == other.productCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, productCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductCategory')
          ..add('id', id)
          ..add('title', title)
          ..add('image', image)
          ..add('category', category)
          ..add('products', products)
          ..add('productCount', productCount))
        .toString();
  }
}

class ProductCategoryBuilder
    implements Builder<ProductCategory, ProductCategoryBuilder> {
  _$ProductCategory? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  int? _category;
  int? get category => _$this._category;
  set category(int? category) => _$this._category = category;

  ListBuilder<ProductModel>? _products;
  ListBuilder<ProductModel> get products =>
      _$this._products ??= new ListBuilder<ProductModel>();
  set products(ListBuilder<ProductModel>? products) =>
      _$this._products = products;

  int? _productCount;
  int? get productCount => _$this._productCount;
  set productCount(int? productCount) => _$this._productCount = productCount;

  ProductCategoryBuilder();

  ProductCategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _image = $v.image;
      _category = $v.category;
      _products = $v.products?.toBuilder();
      _productCount = $v.productCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductCategory other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductCategory;
  }

  @override
  void update(void Function(ProductCategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductCategory build() => _build();

  _$ProductCategory _build() {
    _$ProductCategory _$result;
    try {
      _$result =
          _$v ??
          new _$ProductCategory._(
            id: id,
            title: title,
            image: image,
            category: category,
            products: _products?.build(),
            productCount: productCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        _products?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ProductCategory',
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

class _$ProductDetailModel extends ProductDetailModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? image;
  @override
  final String? flag;
  @override
  final int? expireDate;
  @override
  final bool? isNew;
  @override
  final bool? isPopular;
  @override
  final String? description;
  @override
  final NutritionModel? nutrition;

  factory _$ProductDetailModel([
    void Function(ProductDetailModelBuilder)? updates,
  ]) => (new ProductDetailModelBuilder()..update(updates))._build();

  _$ProductDetailModel._({
    this.id,
    this.title,
    this.image,
    this.flag,
    this.expireDate,
    this.isNew,
    this.isPopular,
    this.description,
    this.nutrition,
  }) : super._();

  @override
  ProductDetailModel rebuild(
    void Function(ProductDetailModelBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductDetailModelBuilder toBuilder() =>
      new ProductDetailModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductDetailModel &&
        id == other.id &&
        title == other.title &&
        image == other.image &&
        flag == other.flag &&
        expireDate == other.expireDate &&
        isNew == other.isNew &&
        isPopular == other.isPopular &&
        description == other.description &&
        nutrition == other.nutrition;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, flag.hashCode);
    _$hash = $jc(_$hash, expireDate.hashCode);
    _$hash = $jc(_$hash, isNew.hashCode);
    _$hash = $jc(_$hash, isPopular.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, nutrition.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductDetailModel')
          ..add('id', id)
          ..add('title', title)
          ..add('image', image)
          ..add('flag', flag)
          ..add('expireDate', expireDate)
          ..add('isNew', isNew)
          ..add('isPopular', isPopular)
          ..add('description', description)
          ..add('nutrition', nutrition))
        .toString();
  }
}

class ProductDetailModelBuilder
    implements Builder<ProductDetailModel, ProductDetailModelBuilder> {
  _$ProductDetailModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _flag;
  String? get flag => _$this._flag;
  set flag(String? flag) => _$this._flag = flag;

  int? _expireDate;
  int? get expireDate => _$this._expireDate;
  set expireDate(int? expireDate) => _$this._expireDate = expireDate;

  bool? _isNew;
  bool? get isNew => _$this._isNew;
  set isNew(bool? isNew) => _$this._isNew = isNew;

  bool? _isPopular;
  bool? get isPopular => _$this._isPopular;
  set isPopular(bool? isPopular) => _$this._isPopular = isPopular;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  NutritionModelBuilder? _nutrition;
  NutritionModelBuilder get nutrition =>
      _$this._nutrition ??= new NutritionModelBuilder();
  set nutrition(NutritionModelBuilder? nutrition) =>
      _$this._nutrition = nutrition;

  ProductDetailModelBuilder();

  ProductDetailModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _image = $v.image;
      _flag = $v.flag;
      _expireDate = $v.expireDate;
      _isNew = $v.isNew;
      _isPopular = $v.isPopular;
      _description = $v.description;
      _nutrition = $v.nutrition?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductDetailModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductDetailModel;
  }

  @override
  void update(void Function(ProductDetailModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductDetailModel build() => _build();

  _$ProductDetailModel _build() {
    _$ProductDetailModel _$result;
    try {
      _$result =
          _$v ??
          new _$ProductDetailModel._(
            id: id,
            title: title,
            image: image,
            flag: flag,
            expireDate: expireDate,
            isNew: isNew,
            isPopular: isPopular,
            description: description,
            nutrition: _nutrition?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nutrition';
        _nutrition?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ProductDetailModel',
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

class _$NutritionModel extends NutritionModel {
  @override
  final double? proteins;
  @override
  final double? fats;
  @override
  final double? carbohydrates;
  @override
  final double? calories;

  factory _$NutritionModel([void Function(NutritionModelBuilder)? updates]) =>
      (new NutritionModelBuilder()..update(updates))._build();

  _$NutritionModel._({
    this.proteins,
    this.fats,
    this.carbohydrates,
    this.calories,
  }) : super._();

  @override
  NutritionModel rebuild(void Function(NutritionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutritionModelBuilder toBuilder() =>
      new NutritionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutritionModel &&
        proteins == other.proteins &&
        fats == other.fats &&
        carbohydrates == other.carbohydrates &&
        calories == other.calories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, proteins.hashCode);
    _$hash = $jc(_$hash, fats.hashCode);
    _$hash = $jc(_$hash, carbohydrates.hashCode);
    _$hash = $jc(_$hash, calories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NutritionModel')
          ..add('proteins', proteins)
          ..add('fats', fats)
          ..add('carbohydrates', carbohydrates)
          ..add('calories', calories))
        .toString();
  }
}

class NutritionModelBuilder
    implements Builder<NutritionModel, NutritionModelBuilder> {
  _$NutritionModel? _$v;

  double? _proteins;
  double? get proteins => _$this._proteins;
  set proteins(double? proteins) => _$this._proteins = proteins;

  double? _fats;
  double? get fats => _$this._fats;
  set fats(double? fats) => _$this._fats = fats;

  double? _carbohydrates;
  double? get carbohydrates => _$this._carbohydrates;
  set carbohydrates(double? carbohydrates) =>
      _$this._carbohydrates = carbohydrates;

  double? _calories;
  double? get calories => _$this._calories;
  set calories(double? calories) => _$this._calories = calories;

  NutritionModelBuilder();

  NutritionModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _proteins = $v.proteins;
      _fats = $v.fats;
      _carbohydrates = $v.carbohydrates;
      _calories = $v.calories;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutritionModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NutritionModel;
  }

  @override
  void update(void Function(NutritionModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutritionModel build() => _build();

  _$NutritionModel _build() {
    final _$result =
        _$v ??
        new _$NutritionModel._(
          proteins: proteins,
          fats: fats,
          carbohydrates: carbohydrates,
          calories: calories,
        );
    replace(_$result);
    return _$result;
  }
}

class _$SectionModel extends SectionModel {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? image;
  @override
  final int? priority;
  @override
  final bool? isActive;
  @override
  final BuiltList<ProductModel>? categories;

  factory _$SectionModel([void Function(SectionModelBuilder)? updates]) =>
      (new SectionModelBuilder()..update(updates))._build();

  _$SectionModel._({
    this.id,
    this.title,
    this.image,
    this.priority,
    this.isActive,
    this.categories,
  }) : super._();

  @override
  SectionModel rebuild(void Function(SectionModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SectionModelBuilder toBuilder() => new SectionModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SectionModel &&
        id == other.id &&
        title == other.title &&
        image == other.image &&
        priority == other.priority &&
        isActive == other.isActive &&
        categories == other.categories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SectionModel')
          ..add('id', id)
          ..add('title', title)
          ..add('image', image)
          ..add('priority', priority)
          ..add('isActive', isActive)
          ..add('categories', categories))
        .toString();
  }
}

class SectionModelBuilder
    implements Builder<SectionModel, SectionModelBuilder> {
  _$SectionModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  int? _priority;
  int? get priority => _$this._priority;
  set priority(int? priority) => _$this._priority = priority;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  ListBuilder<ProductModel>? _categories;
  ListBuilder<ProductModel> get categories =>
      _$this._categories ??= new ListBuilder<ProductModel>();
  set categories(ListBuilder<ProductModel>? categories) =>
      _$this._categories = categories;

  SectionModelBuilder();

  SectionModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _image = $v.image;
      _priority = $v.priority;
      _isActive = $v.isActive;
      _categories = $v.categories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SectionModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SectionModel;
  }

  @override
  void update(void Function(SectionModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SectionModel build() => _build();

  _$SectionModel _build() {
    _$SectionModel _$result;
    try {
      _$result =
          _$v ??
          new _$SectionModel._(
            id: id,
            title: title,
            image: image,
            priority: priority,
            isActive: isActive,
            categories: _categories?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        _categories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'SectionModel',
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
