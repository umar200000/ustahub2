import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../data/model/category_list_model.dart';
import '../data/repo/category_list_repo.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final CategoryListRepo _categoryListRepo = CategoryListRepo();

  CategoryListBloc() : super(const CategoryListState()) {
    on<GetCategoryList>((event, emit) async {
      // Yangi kategorya bo'lsa, state-ni reset qilamiz
      final bool isNewCategory = event.categoryId != state.categoryId;

      if (isNewCategory) {
        emit(
          state.copyWith(
            status: Status2.loading,
            items: [],
            hasReachedMax: false,
            categoryId: event.categoryId,
            errorMessage: null,
          ),
        );
      } else {
        // Agar allaqachon oxiriga yetgan bo'lsak yoki yuklanayotgan bo'lsa, hech narsa qilmaymiz
        if (state.hasReachedMax || state.status == Status2.loading) return;
        emit(state.copyWith(status: Status2.loading));
      }

      try {
        final int skip = isNewCategory ? 0 : state.items.length;

        final response = await _categoryListRepo.getCategoriesList(
          id: event.categoryId,
          skip: skip,
          limit: 20,
        );

        if (response.statusCode == 200) {
          final categoryListResponse = CategoryListResponse.fromJson(
            response.data,
          );
          final items = categoryListResponse.data ?? [];

          if (isNewCategory) {
            emit(
              state.copyWith(
                status: Status2.success,
                items: items,
                hasReachedMax: items.length < 20,
                categoryId: event.categoryId,
              ),
            );
          } else {
            emit(
              items.isEmpty
                  ? state.copyWith(status: Status2.success, hasReachedMax: true)
                  : state.copyWith(
                      status: Status2.success,
                      items: List.of(state.items)..addAll(items),
                      hasReachedMax: items.length < 20,
                    ),
            );
          }
        }
      } on DioException catch (e) {
        String? serverErrorMessage;
        if (e.response?.data != null && e.response?.data is Map) {
          serverErrorMessage =
              e.response?.data['error']?['message'] ??
              e.response?.data['message'];
        }
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: serverErrorMessage ?? e.message ?? "Xatolik",
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: Status2.error, errorMessage: e.toString()));
      }
    });
  }
}
