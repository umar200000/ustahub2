part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryList extends CategoryListEvent {
  final String categoryId;
  final int skip;
  final int limit;

  const GetCategoryList({
    required this.categoryId,
    this.skip = 0,
    this.limit = 20, // Default limit
  });

  @override
  List<Object> get props => [categoryId, skip, limit];
}
