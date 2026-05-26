part of 'express_bloc.dart';

enum ExpressSearchStatus {
  initial,
  loadingCategories,
  categoriesLoaded,
  searching,
  matched,
  noMasters,
  canceled,
  error,
}

class ExpressClientState extends Equatable {
  final ExpressSearchStatus status;
  final List<ExpressProvinceModel> provinces;
  final List<ExpressDistrictModel> districts;
  final List<ExpressCategoryModel> categories;
  final bool provincesLoading;
  final bool districtsLoading;
  final ExpressSessionModel? session;
  final ExpressMatchedModel? matched;
  final String? errorMessage;

  const ExpressClientState({
    this.status = ExpressSearchStatus.initial,
    this.provinces = const [],
    this.districts = const [],
    this.categories = const [],
    this.provincesLoading = false,
    this.districtsLoading = false,
    this.session,
    this.matched,
    this.errorMessage,
  });

  ExpressClientState copyWith({
    ExpressSearchStatus? status,
    List<ExpressProvinceModel>? provinces,
    List<ExpressDistrictModel>? districts,
    List<ExpressCategoryModel>? categories,
    bool? provincesLoading,
    bool? districtsLoading,
    ExpressSessionModel? session,
    ExpressMatchedModel? matched,
    String? errorMessage,
    bool clearSession = false,
    bool clearMatched = false,
    bool clearError = false,
  }) {
    return ExpressClientState(
      status: status ?? this.status,
      provinces: provinces ?? this.provinces,
      districts: districts ?? this.districts,
      categories: categories ?? this.categories,
      provincesLoading: provincesLoading ?? this.provincesLoading,
      districtsLoading: districtsLoading ?? this.districtsLoading,
      session: clearSession ? null : (session ?? this.session),
      matched: clearMatched ? null : (matched ?? this.matched),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        provinces,
        districts,
        categories,
        provincesLoading,
        districtsLoading,
        session,
        matched,
        errorMessage,
      ];
}
