import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/mock_data/mock_data.dart';
import '../data/model/details_model.dart';
import '../data/repo/details_repo.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepo _detailsRepo = DetailsRepo();

  DetailsBloc() : super(const DetailsState()) {
    on<GetServiceDetailsEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _detailsRepo.getServiceDetails(event.serviceId);

        if (response.statusCode == 200) {
          final detailsModel = DetailsServiceModel.fromJson(response.data);

          if (detailsModel.success == true) {
            emit(
              state.copyWith(
                status: Status2.success,
                detailsServiceModel: detailsModel,
              ),
            );
          } else {
            // Use mock data on API failure
            final mockDetails = MockData.getServiceDetails(event.serviceId);
            if (mockDetails != null) {
              emit(
                state.copyWith(
                  status: Status2.success,
                  detailsServiceModel: mockDetails,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: Status2.error,
                  errorMessage: detailsModel.message ?? "Xatolik yuz berdi",
                ),
              );
            }
          }
        }
      } on DioException catch (_) {
        // Use mock data on network error
        final mockDetails = MockData.getServiceDetails(event.serviceId);
        if (mockDetails != null) {
          emit(
            state.copyWith(
              status: Status2.success,
              detailsServiceModel: mockDetails,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: Status2.error,
              errorMessage: "Tarmoq xatoligi",
            ),
          );
        }
      } catch (_) {
        // Use mock data on any error
        final mockDetails = MockData.getServiceDetails(event.serviceId);
        if (mockDetails != null) {
          emit(
            state.copyWith(
              status: Status2.success,
              detailsServiceModel: mockDetails,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: Status2.error,
              errorMessage: "Kutilmagan xatolik",
            ),
          );
        }
      }
    });
  }
}
