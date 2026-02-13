part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String query;
  final bool isNewSearch;

  const SearchQueryEvent({required this.query, this.isNewSearch = false});

  @override
  List<Object?> get props => [query, isNewSearch];
}
