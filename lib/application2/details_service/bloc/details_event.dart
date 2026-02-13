part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetServiceDetailsEvent extends DetailsEvent {
  final String serviceId;

  const GetServiceDetailsEvent({required this.serviceId});

  @override
  List<Object> get props => [serviceId];
}
