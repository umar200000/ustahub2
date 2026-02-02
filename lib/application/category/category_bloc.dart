import 'dart:async';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/infrastructure/repositories/category_repo.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/presentation/components/easy_loading.dart';

part 'category_bloc.freezed.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(const _CategoryState()) {
    on<_GetGroupCatalog>(_getGroupCatalog);
    on<_GetProductMobile>(_getProductMobile);
    on<_GetCategory>(_getCategory);
    on<_GetProductDetail>(_getProductDetail);
    on<_ProductSearch>(_productSearch);
    on<_CreateSearchHistory>(_createSearchHistory);
    on<_GetSearchHistory>(_getSearchHistory);
    on<_DeleteAllSearchHistory>(_deleteAllSearchHistory);
    on<_DeleteSearchHistory>(_deleteSearchHistory);
    on<_InformCreate>(_informCreate);
    on<_AddInform>(_addInform);
    on<_GetInformList>(_getInformList);
    on<_DeleteInform>(_deleteInform);
    on<_DeleteAllInform>(_deleteAllInform);
    on<_GetCategoryCluster>(_getCategoryCluster);
    on<_CreateWish>(_createWish);
  }

  FutureOr<void> _getGroupCatalog(
    _GetGroupCatalog event,
    Emitter<CategoryState> emit,
  ) async {
    if (event.isFirst ?? false) {
      emit(
        state.copyWith(
          statusCatalog: FormzSubmissionStatus.inProgress,
          catalogList: [],
        ),
      );
    }

    final Either<ResponseFailure, Catalog> res;

    if (event.subCategoryId != null ||
        event.brandId != null ||
        event.countryId != null) {
      res = await _categoryRepository.getSearchedProduct(
        page: event.page,
        subCategoryId: event.subCategoryId,
        brandId: event.brandId,
        countryId: event.countryId,
        search: event.brandId == null ? event.search : null,
      );
    } else {
      final categoryId =
          event.categoryId ??
          state.catalogList.lastOrNull?.parents?.elementAtOrNull(1)?.id ??
          0;

      res = await _categoryRepository.getGroupCatalog(
        page: event.page,
        categoryId: event.filter == null ? categoryId : null,
        filter: event.filter,
      );
    }

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusCatalog: FormzSubmissionStatus.failure));
      },
      (data) {
        if (event.onDone != null) {
          event.onDone!();
        }

        final List<SubCategoryModel> catalogList = List.from(state.catalogList);
        catalogList.addAll(data.data?.toList() ?? []);

        emit(
          state.copyWith(
            catalogList: catalogList,
            hasNext: data.hasNext ?? false,
            statusCatalog: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getProductMobile(
    _GetProductMobile event,
    Emitter<CategoryState> emit,
  ) async {
    if (event.isFirst ?? false) {
      emit(
        state.copyWith(
          statusProductMobile: FormzSubmissionStatus.inProgress,
          productCatalog: [],
        ),
      );
    }

    final categoryId =
        event.categoryId ??
        state.catalogList.lastOrNull?.parents?.elementAtOrNull(1)?.id ??
        0;

    final Either<ResponseFailure, ProductCatalogResponse> res;

    if (event.subCategoryId != null ||
        event.brandId != null ||
        event.countryId != null ||
        event.search != null) {
      res = await _categoryRepository.getSearchedProductMobile(
        page: event.page,
        subCategoryId: event.subCategoryId,
        brandId: event.brandId,
        countryId: event.countryId,
        search: event.brandId == null ? event.search : null,
      );
    } else {
      res = await _categoryRepository.getProductMobile(
        page: event.page,
        categoryId: event.filter == null ? categoryId : null,
        filter: event.filter,
      );
    }

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(
          state.copyWith(statusProductMobile: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        if (event.onDone != null) {
          event.onDone!();
        }

        final List<ProductCategory> productCategories = List.from(
          state.productCatalog,
        );
        productCategories.addAll(data.results?.toList() ?? []);

        emit(
          state.copyWith(
            productCatalog: productCategories,
            hasNextProduct: data.next ?? false,
            statusProductMobile: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getCategory(
    _GetCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(statusCategory: FormzSubmissionStatus.inProgress));
    final res = await _categoryRepository.getCategory();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusCategory: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusCategory: FormzSubmissionStatus.success,
            categoryList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getProductDetail(
    _GetProductDetail event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(statusProductDetail: FormzSubmissionStatus.inProgress));
    final res = await _categoryRepository.getProductDetail(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(
          state.copyWith(statusProductDetail: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        emit(
          state.copyWith(
            productDetail: data,
            statusProductDetail: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _productSearch(
    _ProductSearch event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(statusSearch: FormzSubmissionStatus.inProgress));
    // if (event.search.isEmpty) {
    //   emit(state.copyWith(
    //       searchResult: null, statusSearch: FormzSubmissionStatus.initial));
    // } else {
    final res = await _categoryRepository.productSearch(search: event.search);

    res.fold(
      (error) {
        emit(state.copyWith(statusSearch: FormzSubmissionStatus.failure));
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        emit(
          state.copyWith(
            searchResult: data,
            statusSearch: FormzSubmissionStatus.success,
          ),
        );
      },
    );
    // }
  }

  FutureOr<void> _createSearchHistory(
    _CreateSearchHistory event,
    Emitter<CategoryState> emit,
  ) async {
    final res = await _categoryRepository.createSearchHistory(
      search: event.search,
    );

    res.fold((error) {
      LogService.e(" ----> error on bloc  : $error");
    }, (data) {});
  }

  FutureOr<void> _getSearchHistory(
    _GetSearchHistory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(statusSearchHistory: FormzSubmissionStatus.inProgress));
    final res = await _categoryRepository.getSearchHistory();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(
          state.copyWith(statusSearchHistory: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        emit(
          state.copyWith(
            searchHistory: data,
            statusSearchHistory: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _deleteAllSearchHistory(
    _DeleteAllSearchHistory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(searchHistory: []));
    final res = await _categoryRepository.deleteAllSearchHistory();

    res.fold((error) {
      LogService.e(" ----> error on bloc  : $error");
    }, (data) {});
  }

  FutureOr<void> _deleteSearchHistory(
    _DeleteSearchHistory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(
      state.copyWith(
        searchHistory: state.searchHistory
            .where((element) => element.id != event.id)
            .toList(),
      ),
    );

    final res = await _categoryRepository.deleteSearchHistory(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        add(const _GetSearchHistory());
      },
    );
  }

  FutureOr<void> _addInform(
    _AddInform event,
    Emitter<CategoryState> emit,
  ) async {
    // Optimization: Avoid creating a new list when not needed
    // Check if inform already exists in the list
    // First try to find by ID, then by product ID if ID is null
    final existingInformIndex = event.inform.id != null
        ? state.informList.indexWhere((value) => value.id == event.inform.id)
        : state.informList.indexWhere(
            (value) => value.product?.id == event.inform.product?.id,
          );

    if (existingInformIndex >= 0) {
      // Item exists - create a new list with updated item
      final List<InformRes> updatedInformList = List.of(state.informList);
      updatedInformList[existingInformIndex] = event.inform;

      emit(state.copyWith(informList: updatedInformList));
      event.onLogicComplete?.call(updatedInformList);
    } else {
      // Item doesn't exist - add to end efficiently
      final List<InformRes> newInformList = List.of(state.informList)
        ..add(event.inform);
      emit(state.copyWith(informList: newInformList));
      event.onLogicComplete?.call(newInformList);
    }
  }

  FutureOr<void> _informCreate(
    _InformCreate event,
    Emitter<CategoryState> emit,
  ) async {
    // Don't show loading for individual inform creation to avoid UI flicker
    // emit(state.copyWith(statusInform: FormzSubmissionStatus.inProgress));

    final res = await _categoryRepository.informCreate(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        // emit(state.copyWith(statusInform: FormzSubmissionStatus.failure));

        // Revert optimistic update on error
        final updatedList = state.informList
            .where(
              (item) =>
                  item.product?.id != event.request.product || item.id != null,
            )
            .toList();
        emit(state.copyWith(informList: updatedList));
      },
      (data) {
        // Look for existing item by product ID (regardless of inform ID)
        final existingIndex = state.informList.indexWhere(
          (item) => item.product?.id == data.product,
        );

        if (existingIndex >= 0) {
          // Update existing item
          final updatedList = List.of(state.informList);
          updatedList[existingIndex] = updatedList[existingIndex].rebuild(
            (b) => b
              ..id = data.id
              ..count = data.count
              ..isSent = data.isSent,
          );
          emit(
            state.copyWith(
              informList: updatedList,
              statusInform: FormzSubmissionStatus.success,
            ),
          );
        } else {
          // Create new item if it doesn't exist
          final InformRes informData = InformRes(
            (b) => b
              ..id = data.id
              ..count = data.count
              ..isSent = data.isSent
              ..product = ProductModel((b) => b..id = data.product).toBuilder(),
          );

          final informList = List.of(state.informList)..add(informData);
          emit(
            state.copyWith(
              informList: informList,
              statusInform: FormzSubmissionStatus.success,
            ),
          );
        }

        event.onDone();
      },
    );
  }

  FutureOr<void> _getInformList(
    _GetInformList event,
    Emitter<CategoryState> emit,
  ) async {
    // Only show loading if list is empty
    if (state.informList.isEmpty) {
      emit(state.copyWith(statusInform: FormzSubmissionStatus.inProgress));
    }

    final res = await _categoryRepository.getInformList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusInform: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusInform: FormzSubmissionStatus.success,
            informList: data.results?.toList() ?? [],
          ),
        );
      },
    );
  }

  FutureOr<void> _deleteInform(
    _DeleteInform event,
    Emitter<CategoryState> emit,
  ) async {
    // Optimistic update - remove immediately for better UX
    final optimisticList = state.informList
        .where((element) => element.id != event.id)
        .toList();
    emit(state.copyWith(informList: optimisticList));

    final res = await _categoryRepository.deleteInform(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        // Revert optimistic update on error by refreshing from server
        add(const _GetInformList());
        EasyLoading.showError(error.message);
      },
      (data) {
        // Success - optimistic update was correct, no need to refresh from server
      },
    );
  }

  FutureOr<void> _deleteAllInform(
    _DeleteAllInform event,
    Emitter<CategoryState> emit,
  ) async {
    // Optimistic update
    final previousList = state.informList;
    emit(state.copyWith(informList: []));

    final res = await _categoryRepository.deleteAllInform();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        // Revert optimistic update on error
        emit(state.copyWith(informList: previousList));
        EasyLoading.showError(error.message);
      },
      (data) {
        // Success - optimistic update was correct
      },
    );
  }

  FutureOr<void> _getCategoryCluster(
    _GetCategoryCluster event,
    Emitter<CategoryState> emit,
  ) async {
    emit(
      state.copyWith(statusCategoryCluster: FormzSubmissionStatus.inProgress),
    );

    final res = await _categoryRepository.getCategoryCluster();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(
          state.copyWith(statusCategoryCluster: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        emit(
          state.copyWith(
            categoryClusterList: data,
            statusCategoryCluster: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _createWish(
    _CreateWish event,
    Emitter<CategoryState> emit,
  ) async {
    EasyLoading.show();
    final res = await _categoryRepository.createWish(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
      },
      (data) {
        EasyLoading.dismiss();
        event.onDone?.call();
      },
    );
  }
}
