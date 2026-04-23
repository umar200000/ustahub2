import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/model/review_model.dart';
import '../data/repo/review_repo.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepo _reviewRepo = ReviewRepo();

  ReviewBloc() : super(const ReviewState()) {
    on<GetServiceReviewsEvent>(_onGetServiceReviews);
  }

  Future<void> _onGetServiceReviews(
    GetServiceReviewsEvent event,
    Emitter<ReviewState> emit,
  ) async {
    if (event.isFetchMore &&
        (state.isLastPage || state.status == Status2.loading)) {
      return;
    }

    if (!event.isFetchMore) {
      emit(state.copyWith(
        status: Status2.loading,
        isLastPage: false,
        reviews: [],
        total: 0,
      ));
    } else {
      emit(state.copyWith(status: Status2.loading));
    }

    try {
      const int limit = 20;
      final int skip = event.isFetchMore ? state.reviews.length : 0;

      final response = await _reviewRepo.getServiceReviews(
        serviceId: event.serviceId,
        skip: skip,
        limit: limit,
      );

      if (response.statusCode == 200) {
        final parsed = ReviewListResponse.fromJson(response.data);

        if (parsed.success == true) {
          final List<ReviewData> currentList =
              event.isFetchMore ? List<ReviewData>.from(state.reviews) : [];
          final List<ReviewData> newList = parsed.data ?? [];
          final bool isLastPage = newList.length < limit;

          emit(state.copyWith(
            status: Status2.success,
            reviews: [...currentList, ...newList],
            isLastPage: isLastPage,
            total: parsed.total ?? (currentList.length + newList.length),
          ));
        } else {
          emit(state.copyWith(
            status: Status2.error,
            errorMessage: extractFromResponseData(response.data),
          ));
        }
      }
    } on DioException catch (e) {
      emit(state.copyWith(
        status: Status2.error,
        errorMessage: extractErrorMessage(e),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status2.error,
        errorMessage: extractErrorMessage(e),
      ));
    }
  }
}
