part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class GetServiceReviewsEvent extends ReviewEvent {
  final String serviceId;
  final bool isFetchMore;

  const GetServiceReviewsEvent({
    required this.serviceId,
    this.isFetchMore = false,
  });

  @override
  List<Object?> get props => [serviceId, isFetchMore];
}
