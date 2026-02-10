part of 'service_bloc.dart';

class ServiceState extends Equatable {
  final Status2 status;
  final ServicesData? servicesData;
  final String? errorMessage;
  final bool isLastPage;

  const ServiceState({
    this.status = Status2.initial,
    this.servicesData,
    this.errorMessage,
    this.isLastPage = false,
  });

  ServiceState copyWith({
    Status2? status,
    ServicesData? servicesData,
    String? errorMessage,
    bool? isLastPage,
  }) {
    return ServiceState(
      status: status ?? this.status,
      servicesData: servicesData ?? this.servicesData,
      errorMessage: errorMessage ?? this.errorMessage,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [status, servicesData, errorMessage, isLastPage];
}
