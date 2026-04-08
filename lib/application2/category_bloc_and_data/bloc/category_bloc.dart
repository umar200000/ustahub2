import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/model/category_model.dart';
import '../data/repo/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo _categoryRepo = CategoryRepo();

  CategoryBloc() : super(const CategoryState()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _categoryRepo.getCategories();

        if (response.statusCode == 200) {
          final categoryData = CategoryData.fromJson(response.data);

          if (categoryData.success == true) {
            emit(
              state.copyWith(
                status: Status2.success,
                categoryData: categoryData,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: Status2.error,
                errorMessage: extractFromResponseData(response.data),
              ),
            );
          }
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      }
    });
  }
}
