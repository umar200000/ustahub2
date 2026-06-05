part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String query;
  final bool isNewSearch;
  final String? provinceId;
  final String? districtId;

  const SearchQueryEvent({
    required this.query,
    this.isNewSearch = false,
    this.provinceId,
    this.districtId,
  });

  @override
  List<Object?> get props => [query, isNewSearch, provinceId, districtId];
}

class SearchFilterEvent extends SearchEvent {
  final String? provinceId;
  final String? provinceName;
  final String? districtId;
  final String? districtName;

  const SearchFilterEvent({
    this.provinceId,
    this.provinceName,
    this.districtId,
    this.districtName,
  });

  @override
  List<Object?> get props => [provinceId, provinceName, districtId, districtName];
}
