import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/mock_data/mock_data.dart';
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
            print("------work-----");
            categoryData.categoryModel?.forEach((value) {
              print("value.nameUz: ${value.nameUz}");
            });
            emit(
              state.copyWith(
                status: Status2.success,
                categoryData: categoryData,
              ),
            );
          } else {
            // Use mock data on API failure
            emit(
              state.copyWith(
                status: Status2.success,
                categoryData: MockData.categories,
              ),
            );
          }
        }
      } on DioException catch (e) {
        // Use mock data on network error
        emit(
          state.copyWith(
            status: Status2.success,
            categoryData: MockData.categories,
          ),
        );
      } catch (e) {
        // Use mock data on any error
        emit(
          state.copyWith(
            status: Status2.success,
            categoryData: MockData.categories,
          ),
        );
      }
    });
  }
}
