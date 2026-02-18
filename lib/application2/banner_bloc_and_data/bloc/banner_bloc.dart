import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../data/model/banner_details_model.dart';
import '../data/model/banner_model.dart';
import '../data/repo/banner_repo.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepo _bannerRepo = BannerRepo();

  BannerBloc() : super(const BannerState()) {
    on<GetBannersEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _bannerRepo.getBanners();

        if (response.statusCode == 200) {
          print("is working? ${response.data}");
          final bannerModel = BannerModel.fromJson(response.data);

          if (bannerModel.success == true) {
            emit(
              state.copyWith(status: Status2.success, bannerModel: bannerModel),
            );
          } else {
            emit(
              state.copyWith(
                status: Status2.error,
                errorMessage: bannerModel.error?.toString() ?? "Xatolik",
              ),
            );
          }
        }
      } on DioException catch (e) {
        emit(state.copyWith(status: Status2.error, errorMessage: e.message));
      } catch (e) {
        emit(state.copyWith(status: Status2.error, errorMessage: e.toString()));
      }
    });

    on<GetBannerDetailsEvent>((event, emit) async {
      emit(state.copyWith(detailsStatus: Status2.loading));

      try {
        final response = await _bannerRepo.getBannerDetails(id: event.id);

        if (response.statusCode == 200) {
          final bannerDetailsModel = BannerDetailsModel.fromJson(response.data);

          if (bannerDetailsModel.success == true) {
            emit(
              state.copyWith(
                detailsStatus: Status2.success,
                bannerDetailsModel: bannerDetailsModel,
              ),
            );
          } else {
            emit(
              state.copyWith(
                detailsStatus: Status2.error,
                errorMessage: bannerDetailsModel.message ?? "Xatolik",
              ),
            );
          }
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(detailsStatus: Status2.error, errorMessage: e.message),
        );
      } catch (e) {
        emit(
          state.copyWith(
            detailsStatus: Status2.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
