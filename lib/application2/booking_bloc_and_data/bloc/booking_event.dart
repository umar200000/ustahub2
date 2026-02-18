part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class CreateBookingEvent extends BookingEvent {
  final String serviceId;
  final int latitude;
  final int longitude;
  final String scheduledDate;
  final String scheduledTimeStart;
  final String address;
  final String userComment;

  const CreateBookingEvent({
    required this.serviceId,
    required this.latitude,
    required this.longitude,
    required this.scheduledDate,
    required this.scheduledTimeStart,
    required this.address,
    required this.userComment,
  });

  @override
  List<Object?> get props => [
    serviceId,
    latitude,
    longitude,
    scheduledDate,
    scheduledTimeStart,
    address,
    userComment,
  ];
}

class GetBookingsListEvent extends BookingEvent {
  final bool isRefresh;
  const GetBookingsListEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class GetBookingDetailsEvent extends BookingEvent {
  final String id;
  const GetBookingDetailsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
