part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final Status2 status;
  final List<ReviewData> reviews;
  final String? errorMessage;
  final bool isLastPage;
  final int total;

  const ReviewState({
    this.status = Status2.initial,
    this.reviews = const [],
    this.errorMessage,
    this.isLastPage = false,
    this.total = 0,
  });

  ReviewState copyWith({
    Status2? status,
    List<ReviewData>? reviews,
    String? errorMessage,
    bool? isLastPage,
    int? total,
  }) {
    return ReviewState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      errorMessage: errorMessage ?? this.errorMessage,
      isLastPage: isLastPage ?? this.isLastPage,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [status, reviews, errorMessage, isLastPage, total];
}
