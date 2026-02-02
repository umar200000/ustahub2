part of 'category_bloc.dart';

@freezed
abstract class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.getGroupCatalog({
    required int page,
    int? categoryId,
    VoidCallback? onDone,
    bool? isFirst,
    int? subCategoryId,
    int? brandId,
    int? countryId,
    FilterItemModel? filter,
    String? search,
  }) = _GetGroupCatalog;

  // const factory CategoryEvent.getGroupCatalogDecrement(
  //     {required int page, int? categoryId, FilterItemModel? filter, required VoidCallback onDone}) = _GetGroupCatalogDecrement;

  const factory CategoryEvent.getCategory() = _GetCategory;

  const factory CategoryEvent.getProductDetail({required int id}) = _GetProductDetail;

  const factory CategoryEvent.productSearch({required String? search}) = _ProductSearch;

  const factory CategoryEvent.createSearchHistory({required ProductModel search}) = _CreateSearchHistory;

  const factory CategoryEvent.getSearchHistory() = _GetSearchHistory;

  const factory CategoryEvent.deleteAllSearchHistory() = _DeleteAllSearchHistory;

  const factory CategoryEvent.deleteSearchHistory({required int id}) = _DeleteSearchHistory;

  const factory CategoryEvent.informCreate({required InformModel request, required VoidCallback onDone}) = _InformCreate;

  const factory CategoryEvent.addInform({required InformRes inform, Function(List<InformRes>)? onLogicComplete}) = _AddInform;

  const factory CategoryEvent.getInformList() = _GetInformList;

  const factory CategoryEvent.deleteInform({required int id}) = _DeleteInform;

  const factory CategoryEvent.deleteAllInform() = _DeleteAllInform;

  const factory CategoryEvent.getCategoryCluster() = _GetCategoryCluster;

  const factory CategoryEvent.getProductMobile({
    required int page,
    int? categoryId,
    FilterItemModel? filter,
    bool? isFirst,
    VoidCallback? onDone,
    int? subCategoryId,
    int? brandId,
    int? countryId,
    String? search,
  }) = _GetProductMobile;

  const factory CategoryEvent.createWish({required OrderReq request, VoidCallback? onDone}) = _CreateWish;
}
