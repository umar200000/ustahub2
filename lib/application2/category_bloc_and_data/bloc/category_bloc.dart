import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
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
            emit(
              state.copyWith(
                status: Status2.error,
                errorMessage:
                    categoryData.error?.toString() ?? "Xatolik yuz berdi",
              ),
            );
          }
        }
      } on DioException catch (e) {
        String? serverErrorMessage;

        if (e.response?.data != null) {
          final responseData = e.response?.data;
          if (responseData is Map) {
            if (responseData.containsKey('error')) {
              serverErrorMessage = responseData['error']['message'];
            } else if (responseData.containsKey('message')) {
              serverErrorMessage = responseData['message'];
            }
          }
        }

        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: serverErrorMessage ?? e.message ?? "Tarmoq xatoligi",
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: "Kutilmagan xatolik: ${e.toString()}",
          ),
        );
      }
    });
  }
}
