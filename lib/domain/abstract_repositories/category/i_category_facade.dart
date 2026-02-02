import 'package:dartz/dartz.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';

abstract class ICategoryFacade {
  Future<Either<ResponseFailure, Catalog>> getGroupCatalog({
    required int page,
    int? categoryId,
    FilterItemModel? filter,
  });

  Future<Either<ResponseFailure, ProductCatalogResponse>> getProductMobile({
    required int page,
    int? categoryId,
    FilterItemModel? filter,
  });

  Future<Either<ResponseFailure, List<ProductModel>>> getCategory();

  Future<Either<ResponseFailure, ProductDetailModel>> getProductDetail({
    required int id,
  });

  Future<Either<ResponseFailure, SearchModel>> productSearch({
    required String? search,
  });

  Future<Either<ResponseFailure, Catalog>> getSearchedProduct({
    required int page,
    int? subCategoryId,
    int? brandId,
    int? countryId,
    int? categoryId,
    String? search,
  });

  Future<Either<ResponseFailure, ProductCatalogResponse>>
  getSearchedProductMobile({
    required int page,
    int? subCategoryId,
    int? brandId,
    int? countryId,
    int? categoryId,
    String? search,
  });

  Future<Either<ResponseFailure, ProductModel>> createSearchHistory({
    required ProductModel search,
  });

  Future<Either<ResponseFailure, List<ProductModel>>> getSearchHistory();

  Future<Either<ResponseFailure, dynamic>> deleteAllSearchHistory();

  Future<Either<ResponseFailure, dynamic>> deleteSearchHistory({
    required int id,
  });

  Future<Either<ResponseFailure, dynamic>> informCreate({
    required InformModel request,
  });

  Future<Either<ResponseFailure, Inform>> getInformList();

  Future<Either<ResponseFailure, dynamic>> deleteInform({required int id});

  Future<Either<ResponseFailure, dynamic>> deleteAllInform();

  Future<Either<ResponseFailure, List<CategoryListModel>>> getCategoryCluster();

  Future<Either<ResponseFailure, OrderReq>> createWish({
    required OrderReq request,
  });
}
