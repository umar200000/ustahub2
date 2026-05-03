part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class CreateBookingEvent extends BookingEvent {
  final String serviceId;
  final double latitude;
  final double longitude;
  final String scheduledDate;
  final String scheduledTimeStart;
  final String address;
  final String userComment;
  // Test rejimi uchun ko'rsatish ma'lumotlari (booking listida title/provider
  // ko'rinishi uchun). Real backend bu fieldlarni e'tiborga olmaydi.
  final String? serviceTitle;
  final String? providerName;
  final String? providerLogo;
  final double? totalPrice;

  const CreateBookingEvent({
    required this.serviceId,
    required this.latitude,
    required this.longitude,
    required this.scheduledDate,
    required this.scheduledTimeStart,
    required this.address,
    required this.userComment,
    this.serviceTitle,
    this.providerName,
    this.providerLogo,
    this.totalPrice,
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
    serviceTitle,
    providerName,
    providerLogo,
    totalPrice,
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

class ConfirmArrivalEvent extends BookingEvent {
  final String bookingId;

  const ConfirmArrivalEvent({required this.bookingId});

  @override
  List<Object?> get props => [bookingId];
}

class CancelBookingEvent extends BookingEvent {
  final String bookingId;
  final String cancellationReason;

  const CancelBookingEvent({
    required this.bookingId,
    required this.cancellationReason,
  });

  @override
  List<Object?> get props => [bookingId, cancellationReason];
}

class SetReviewEvent extends BookingEvent {
  final String bookingId;
  final int rating;
  final String comment;

  const SetReviewEvent({
    required this.bookingId,
    required this.rating,
    required this.comment,
  });

  @override
  List<Object?> get props => [bookingId, rating, comment];
}
