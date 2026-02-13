part of 'search_bloc.dart';

class SearchState extends Equatable {
  final Status2 status;
  final List<SearchListItem> items;
  final bool hasReachedMax;
  final String? errorMessage;
  final String query;

  const SearchState({
    this.status = Status2.initial,
    this.items = const [],
    this.hasReachedMax = false,
    this.errorMessage,
    this.query = '',
  });

  SearchState copyWith({
    Status2? status,
    List<SearchListItem>? items,
    bool? hasReachedMax,
    String? errorMessage,
    String? query,
  }) {
    return SearchState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    hasReachedMax,
    errorMessage,
    query,
  ];
}
