part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final Status2 status;
  final CategoryData? categoryData;
  final String? errorMessage;

  const CategoryState({
    this.status = Status2.initial,
    this.categoryData,
    this.errorMessage,
  });

  CategoryState copyWith({
    Status2? status,
    CategoryData? categoryData,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categoryData: categoryData ?? this.categoryData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categoryData, errorMessage];
}
