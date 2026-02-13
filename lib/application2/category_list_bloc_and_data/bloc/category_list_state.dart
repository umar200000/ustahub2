part of 'category_list_bloc.dart';

class CategoryListState extends Equatable {
  final Status2 status;
  final List<CategoryListItem> items;
  final bool hasReachedMax;
  final String? errorMessage;
  final String? categoryId; // Yangi qo'shildi

  const CategoryListState({
    this.status = Status2.initial,
    this.items = const [],
    this.hasReachedMax = false,
    this.errorMessage,
    this.categoryId,
  });

  CategoryListState copyWith({
    Status2? status,
    List<CategoryListItem>? items,
    bool? hasReachedMax,
    String? errorMessage,
    String? categoryId,
  }) {
    return CategoryListState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [status, items, hasReachedMax, errorMessage, categoryId];
}
