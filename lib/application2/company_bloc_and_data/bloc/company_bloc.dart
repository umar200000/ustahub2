import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ustahub/application2/service_bloc_and_data/data/model/service_model.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/infrastructure/services/mock_data/mock_data.dart';
import 'package:ustahub/infrastructure2/common/error_helper.dart';

import '../data/model/company_details_model.dart';
import '../data/model/company_model.dart';
import '../data/repo/company_repo.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepo _companyRepo = CompanyRepo();

  CompanyBloc() : super(const CompanyState()) {
    on<GetCompaniesEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _companyRepo.getProviders();

        if (response.statusCode == 200) {
          final companyResponse = CompanyResponse.fromJson(response.data);

          if (companyResponse.success == true) {
            emit(
              state.copyWith(
                status: Status2.success,
                companyResponse: companyResponse,
              ),
            );
          } else {
            // Use mock data on API failure
            emit(
              state.copyWith(
                status: Status2.success,
                companyResponse: MockData.companies,
              ),
            );
          }
        }
      } on DioException catch (e) {
        // Use mock data on network error
        emit(
          state.copyWith(
            status: Status2.success,
            companyResponse: MockData.companies,
          ),
        );
      } catch (e) {
        // Use mock data on any error
        emit(
          state.copyWith(
            status: Status2.success,
            companyResponse: MockData.companies,
          ),
        );
      }
    });

    on<GetProviderDetailsEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _companyRepo.getProviderDetails(
          event.providerId,
        );

        if (response.statusCode == 200) {
          final companyDetailsResponse = CompanyDetailsResponse.fromJson(
            response.data,
          );

          if (companyDetailsResponse.success == true) {
            emit(
              state.copyWith(
                status: Status2.success,
                companyDetailsResponse: companyDetailsResponse,
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

    on<GetProviderServicesEvent>((event, emit) async {
      if (state.hasReachedMax && event.isFetchMore) return;

      if (!event.isFetchMore) {
        emit(
          state.copyWith(
            status: Status2.loading,
            skip: 0,
            hasReachedMax: false,
            servicesData: null,
          ),
        );
      } else {
        emit(state.copyWith(status: Status2.loading));
      }

      try {
        final response = await _companyRepo.getProviderServices(
          event.providerId,
          skip: state.skip,
          limit: 20,
        );

        if (response.statusCode == 200) {
          final newServicesData = ServicesData.fromJson(response.data);

          if (newServicesData.success == true) {
            final List<ServicesModel> oldServices =
                state.servicesData?.servicesModel ?? [];
            final List<ServicesModel> newServicesList =
                newServicesData.servicesModel ?? [];

            final List<ServicesModel> updatedServices = event.isFetchMore
                ? [...oldServices, ...newServicesList]
                : newServicesList;

            emit(
              state.copyWith(
                status: Status2.success,
                servicesData: ServicesData(
                  success: true,
                  servicesModel: updatedServices,
                  message: newServicesData.message,
                ),
                skip: state.skip + newServicesList.length,
                hasReachedMax: newServicesList.length < 20,
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
