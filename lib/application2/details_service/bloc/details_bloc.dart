import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure2/common/error_helper.dart';
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
            emit(
              state.copyWith(
                status: Status2.error,
                errorMessage: extractFromResponseData(response.data),
              ),
            );
          }
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      }
    });
  }
}
