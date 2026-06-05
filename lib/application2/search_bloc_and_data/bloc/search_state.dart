part of 'search_bloc.dart';

class SearchState extends Equatable {
  final Status2 status;
  final List<ServicesModel> items;
  final bool hasReachedMax;
  final String? errorMessage;
  final String query;
  final String? selectedProvinceId;
  final String? selectedProvinceName;
  final String? selectedDistrictId;
  final String? selectedDistrictName;

  const SearchState({
    this.status = Status2.initial,
    this.items = const [],
    this.hasReachedMax = false,
    this.errorMessage,
    this.query = '',
    this.selectedProvinceId,
    this.selectedProvinceName,
    this.selectedDistrictId,
    this.selectedDistrictName,
  });

  bool get hasFilter =>
      selectedProvinceId != null || selectedDistrictId != null;

  SearchState copyWith({
    Status2? status,
    List<ServicesModel>? items,
    bool? hasReachedMax,
    String? errorMessage,
    String? query,
    String? selectedProvinceId,
    String? selectedProvinceName,
    String? selectedDistrictId,
    String? selectedDistrictName,
    bool clearProvince = false,
    bool clearDistrict = false,
  }) {
    return SearchState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
      selectedProvinceId:
          clearProvince ? null : selectedProvinceId ?? this.selectedProvinceId,
      selectedProvinceName:
          clearProvince ? null : selectedProvinceName ?? this.selectedProvinceName,
      selectedDistrictId:
          clearDistrict ? null : selectedDistrictId ?? this.selectedDistrictId,
      selectedDistrictName:
          clearDistrict ? null : selectedDistrictName ?? this.selectedDistrictName,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    hasReachedMax,
    errorMessage,
    query,
    selectedProvinceId,
    selectedProvinceName,
    selectedDistrictId,
    selectedDistrictName,
  ];
}
