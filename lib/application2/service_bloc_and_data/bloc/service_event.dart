part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class GetServicesEvent extends ServiceEvent {
  final bool isFetchMore;
  const GetServicesEvent({this.isFetchMore = false});

  @override
  List<Object> get props => [isFetchMore];
}
