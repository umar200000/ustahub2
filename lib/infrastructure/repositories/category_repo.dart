import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ustahub/domain/abstract_repositories/category/i_category_facade.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/infrastructure/apis/apis.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

class CategoryRepository implements ICategoryFacade {
  final StoreService _service;
  final AssetService _assetService;

  CategoryRepository(this._service, this._assetService);

  @override
  Future<Either<ResponseFailure, Catalog>> getGroupCatalog({
    required int page,
    int? categoryId,
    FilterItemModel? filter,
  }) async {
    try {
      final res = await _service.getGroupCatalog(
        page: page,
        categoryId: categoryId ?? filter?.categoryId,
        brandId: filter?.brandId,
        countryId: filter?.countryId,
        setId: filter?.setId,
      );
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProductCatalogResponse>> getProductMobile({
    required int page,
    int? categoryId,
    FilterItemModel? filter,
  }) async {
    try {
      final res = await _service.getProductMobile(
        page: page,
        categoryId: categoryId ?? filter?.categoryId,
        brandId: filter?.brandId,
        countryId: filter?.countryId,
        setId: filter?.setId,
      );
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<ProductModel>>> getCategory() async {
    try {
      final res = await _service.getCategory();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, SearchModel>> productSearch({
    required String? search,
  }) async {
    try {
      final res = await _service.productSearch(search: search);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, Catalog>> getSearchedProduct({
    required int page,
    int? subCategoryId,
    int? brandId,
    int? countryId,
    String? search,
    int? categoryId,
  }) async {
    try {
      final res = await _service.getSearchedProduct(
        page: page,
        subCategoryId: subCategoryId,
        brandId: brandId,
        countryId: countryId,
        search: search,
        categoryId: categoryId,
      );
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProductCatalogResponse>>
  getSearchedProductMobile({
    required int page,
    int? subCategoryId,
    int? brandId,
    int? countryId,
    String? search,
    int? categoryId,
  }) async {
    try {
      final res = await _service.getSearchedProductMobile(
        page: page,
        subCategoryId: subCategoryId,
        brandId: brandId,
        countryId: countryId,
        search: search,
        categoryId: categoryId,
      );
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProductModel>> createSearchHistory({
    required ProductModel search,
  }) async {
    try {
      final res = await _service.createSearchHistory(search: search);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<ProductModel>>> getSearchHistory() async {
    try {
      final res = await _service.getSearchHistory();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteAllSearchHistory() async {
    try {
      final res = await _service.deleteAllSearchHistory();
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteSearchHistory({
    required int id,
  }) async {
    try {
      final res = await _service.deleteSearchHistory(id: id);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> informCreate({
    required InformModel request,
  }) async {
    try {
      final res = await _assetService.informCreate(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, Inform>> getInformList() async {
    try {
      final res = await _assetService.getInformList();
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteInform({
    required int id,
  }) async {
    try {
      final res = await _assetService.deleteInform(id: id);
      if (res.isSuccessful) {
        return right(res.body);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, dynamic>> deleteAllInform() async {
    try {
      final res = await _assetService.deleteAllInform();
      if (res.isSuccessful) {
        return right(res.body);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, ProductDetailModel>> getProductDetail({
    required int id,
  }) async {
    try {
      final res = await _service.getProductDetail(id: id);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, List<CategoryListModel>>>
  getCategoryCluster() async {
    try {
      final res = await _service.getCategoryCluster();
      if (res.isSuccessful) {
        return right(res.body!.toList());
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : ${e.toString()}");
      return left(handleError(e));
    }
  }

  @override
  Future<Either<ResponseFailure, OrderReq>> createWish({
    required OrderReq request,
  }) async {
    try {
      final res = await _service.createWish(request: request);
      if (res.isSuccessful) {
        return right(res.body!);
      } else {
        return left(InvalidCredentials(message: 'invalid_credential'.tr()));
      }
    } catch (e) {
      LogService.e(" ----> error on repo  : $e");
      return left(handleError(e));
    }
  }
}
