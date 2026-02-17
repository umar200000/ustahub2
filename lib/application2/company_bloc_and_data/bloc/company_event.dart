part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class GetCompaniesEvent extends CompanyEvent {}

class GetProviderDetailsEvent extends CompanyEvent {
  final String providerId;

  const GetProviderDetailsEvent({required this.providerId});

  @override
  List<Object> get props => [providerId];
}

class GetProviderServicesEvent extends CompanyEvent {
  final String providerId;
  final bool isFetchMore;

  const GetProviderServicesEvent({
    required this.providerId,
    this.isFetchMore = false,
  });

  @override
  List<Object> get props => [providerId, isFetchMore];
}
