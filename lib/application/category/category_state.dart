part of 'category_bloc.dart';

@immutable
@freezed
class CategoryState with _$CategoryState {
  const CategoryState._();

  const factory CategoryState({
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
    @Default(false) bool hasNextProduct,
    @Default([]) List<SubCategoryModel> catalogList,
    @Default([]) List<ProductCategory> productCatalog,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusCatalog,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusProductMobile,
    @Default([]) List<ProductModel> categoryList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusCategory,
    @Default(null) SearchModel? searchResult,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusSearch,
    @Default([]) List<ProductModel> searchHistory,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusSearchHistory,
    @Default([]) List<InformRes> informList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusInform,
    @Default(null) ProductDetailModel? productDetail,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusProductDetail,
    @Default([]) List<CategoryListModel> categoryClusterList,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusCategoryCluster,
  }) = _CategoryState;
}
