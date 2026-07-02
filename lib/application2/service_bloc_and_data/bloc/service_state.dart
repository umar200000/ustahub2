part of 'service_bloc.dart';

// Sentinel object used in copyWith to distinguish "not provided" from explicit null.
const _keep = Object();

class ServiceState extends Equatable {
  final Status2 status;
  final ServicesData? servicesData;
  final String? errorMessage;
  final bool isLastPage;
  final double? latitude;
  final double? longitude;

  const ServiceState({
    this.status = Status2.initial,
    this.servicesData,
    this.errorMessage,
    this.isLastPage = false,
    this.latitude,
    this.longitude,
  });

  ServiceState copyWith({
    Status2? status,
    ServicesData? servicesData,
    String? errorMessage,
    bool? isLastPage,
    // Use explicit sentinel to allow clearing lat/lng back to null.
    Object? latitude = _keep,
    Object? longitude = _keep,
  }) {
    return ServiceState(
      status: status ?? this.status,
      servicesData: servicesData ?? this.servicesData,
      errorMessage: errorMessage ?? this.errorMessage,
      isLastPage: isLastPage ?? this.isLastPage,
      latitude: latitude == _keep ? this.latitude : latitude as double?,
      longitude: longitude == _keep ? this.longitude : longitude as double?,
    );
  }

  @override
  List<Object?> get props =>
      [status, servicesData, errorMessage, isLastPage, latitude, longitude];
}
