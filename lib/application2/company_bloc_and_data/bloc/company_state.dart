part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final Status2 status;
  final CompanyResponse? companyResponse;
  final CompanyDetailsResponse? companyDetailsResponse;
  final ServicesData? servicesData; // Yangi qo'shildi
  final String? errorMessage;
  final int skip; // Pagination uchun
  final bool hasReachedMax; // Pagination uchun

  const CompanyState({
    this.status = Status2.initial,
    this.companyResponse,
    this.companyDetailsResponse,
    this.servicesData,
    this.errorMessage,
    this.skip = 0,
    this.hasReachedMax = false,
  });

  CompanyState copyWith({
    Status2? status,
    CompanyResponse? companyResponse,
    CompanyDetailsResponse? companyDetailsResponse,
    ServicesData? servicesData,
    String? errorMessage,
    int? skip,
    bool? hasReachedMax,
  }) {
    return CompanyState(
      status: status ?? this.status,
      companyResponse: companyResponse ?? this.companyResponse,
      companyDetailsResponse:
          companyDetailsResponse ?? this.companyDetailsResponse,
      servicesData: servicesData ?? this.servicesData,
      errorMessage: errorMessage ?? this.errorMessage,
      skip: skip ?? this.skip,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    status,
    companyResponse,
    companyDetailsResponse,
    servicesData,
    errorMessage,
    skip,
    hasReachedMax,
  ];
}
