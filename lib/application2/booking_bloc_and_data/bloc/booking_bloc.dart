import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../data/model/booking_model.dart';
import '../data/model/booking_model_list.dart';
import '../data/repo/booking_repo.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepo _bookingRepo = BookingRepo();

  BookingBloc() : super(const BookingState()) {
    on<CreateBookingEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _bookingRepo.bookingService(
          serviceId: event.serviceId,
          latitude: event.latitude,
          longitude: event.longitude,
          scheduledDate: event.scheduledDate,
          scheduledTimeStart: event.scheduledTimeStart,
          address: event.address,
          userComment: event.userComment,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(
            state.copyWith(
              status: Status2.success,
              successMessage: "Buyurtma muvaffaqiyatli yaratildi",
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: Status2.error,
              errorMessage: response.data["message"] ?? "Xatolik yuz berdi",
            ),
          );
        }
      } on DioException catch (e) {
        String? serverErrorMessage;

        if (e.response?.data != null) {
          final responseData = e.response?.data;
          if (responseData is Map) {
            if (responseData.containsKey('error')) {
              serverErrorMessage = responseData['error']['message'];
            } else if (responseData.containsKey('message')) {
              serverErrorMessage = responseData['message'];
            }
          }
        }

        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: serverErrorMessage ?? e.message ?? "Tarmoq xatoligi",
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: "Kutilmagan xatolik: ${e.toString()}",
          ),
        );
      }
    });

    on<GetBookingsListEvent>((event, emit) async {
      if (!event.isRefresh &&
          (state.hasReachedMax || state.listStatus == Status2.loading)) {
        return;
      }

      if (event.isRefresh) {
        emit(state.copyWith(
          listStatus: Status2.loading,
          items: [],
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(listStatus: Status2.loading));
      }

      try {
        const int limit = 20;
        final int skip = event.isRefresh ? 0 : state.items.length;

        final response = await _bookingRepo.getBookingsList(
          limit: limit,
          skip: skip,
        );

        if (response.statusCode == 200) {
          final bookingModelList = BookingModelList.fromJson(response.data);

          if (bookingModelList.success == true) {
            final List<BookingListItem> newList = bookingModelList.data ?? [];

            final List<BookingListItem> currentItems =
                event.isRefresh ? [] : List.of(state.items);

            int newAddedCount = 0;
            for (var item in newList) {
              if (!currentItems.any((e) => e.id == item.id)) {
                currentItems.add(item);
                newAddedCount++;
              }
            }

            final bool reachedMax = newList.length < limit || newAddedCount == 0;

            emit(
              state.copyWith(
                listStatus: Status2.success,
                items: currentItems,
                hasReachedMax: reachedMax,
              ),
            );
          } else {
            emit(
              state.copyWith(
                listStatus: Status2.error,
                errorMessage: bookingModelList.error?.toString() ?? "Xatolik",
              ),
            );
          }
        }
      } on DioException catch (e) {
        emit(state.copyWith(listStatus: Status2.error, errorMessage: e.message));
      } catch (e) {
        emit(state.copyWith(
            listStatus: Status2.error, errorMessage: e.toString()));
      }
    });

    on<GetBookingDetailsEvent>((event, emit) async {
      emit(state.copyWith(detailsStatus: Status2.loading));

      try {
        final response = await _bookingRepo.getBookingDetails(id: event.id);

        if (response.statusCode == 200) {
          final bookingModel = BookingModel.fromJson(response.data);

          if (bookingModel.success == true) {
            emit(
              state.copyWith(
                detailsStatus: Status2.success,
                bookingModel: bookingModel,
              ),
            );
          } else {
            emit(
              state.copyWith(
                detailsStatus: Status2.error,
                errorMessage:
                    bookingModel.error?.toString() ?? "Xatolik yuz berdi",
              ),
            );
          }
        }
      } on DioException catch (e) {
        String? serverErrorMessage;

        if (e.response?.data != null) {
          final responseData = e.response?.data;
          if (responseData is Map) {
            if (responseData.containsKey('error')) {
              serverErrorMessage = responseData['error']['message'];
            } else if (responseData.containsKey('message')) {
              serverErrorMessage = responseData['message'];
            }
          }
        }

        emit(
          state.copyWith(
            detailsStatus: Status2.error,
            errorMessage: serverErrorMessage ?? e.message ?? "Tarmoq xatoligi",
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            detailsStatus: Status2.error,
            errorMessage: "Kutilmagan xatolik: ${e.toString()}",
          ),
        );
      }
    });
  }
}
