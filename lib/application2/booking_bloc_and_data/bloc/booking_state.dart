part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final Status2 status;
  final Status2 listStatus;
  final Status2 detailsStatus;
  final List<BookingListItem> items;
  final BookingModel? bookingModel;
  final bool hasReachedMax;
  final String? errorMessage;
  final String? successMessage;

  const BookingState({
    this.status = Status2.initial,
    this.listStatus = Status2.initial,
    this.detailsStatus = Status2.initial,
    this.items = const [],
    this.bookingModel,
    this.hasReachedMax = false,
    this.errorMessage,
    this.successMessage,
  });

  BookingState copyWith({
    Status2? status,
    Status2? listStatus,
    Status2? detailsStatus,
    List<BookingListItem>? items,
    BookingModel? bookingModel,
    bool? hasReachedMax,
    String? errorMessage,
    String? successMessage,
  }) {
    return BookingState(
      status: status ?? this.status,
      listStatus: listStatus ?? this.listStatus,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      items: items ?? this.items,
      bookingModel: bookingModel ?? this.bookingModel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    listStatus,
    detailsStatus,
    items,
    bookingModel,
    hasReachedMax,
    errorMessage,
    successMessage,
  ];
}
