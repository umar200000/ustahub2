part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final Status2 status;
  final Status2 listStatus;
  final Status2 detailsStatus;
  final Status2 reviewStatus;
  final Status2 cancelStatus;
  final Status2 confirmArrivalStatus;
  final List<BookingListItem> items;
  final BookingModel? bookingModel;
  final bool hasReachedMax;
  final String? errorMessage;
  final String? successMessage;

  const BookingState({
    this.status = Status2.initial,
    this.listStatus = Status2.initial,
    this.detailsStatus = Status2.initial,
    this.reviewStatus = Status2.initial,
    this.cancelStatus = Status2.initial,
    this.confirmArrivalStatus = Status2.initial,
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
    Status2? reviewStatus,
    Status2? cancelStatus,
    Status2? confirmArrivalStatus,
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
      reviewStatus: reviewStatus ?? this.reviewStatus,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      confirmArrivalStatus: confirmArrivalStatus ?? this.confirmArrivalStatus,
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
    reviewStatus,
    cancelStatus,
    confirmArrivalStatus,
    items,
    bookingModel,
    hasReachedMax,
    errorMessage,
    successMessage,
  ];
}
