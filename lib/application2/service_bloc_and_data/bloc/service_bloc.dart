import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/mock_data/mock_data.dart';
import '../data/model/service_model.dart';
import '../data/repo/service_repo.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepo _serviceRepo = ServiceRepo();

  ServiceBloc() : super(const ServiceState()) {
    on<GetServicesEvent>((event, emit) async {
      // Agar oxirgi sahifa bo'lsa yoki yuklanayotgan bo'lsa, qaytib ketamiz
      if (event.isFetchMore &&
          (state.isLastPage || state.status == Status2.loading)) {
        return;
      }

      if (!event.isFetchMore) {
        emit(state.copyWith(status: Status2.loading, isLastPage: false));
      } else {
        // Fetch more bo'lganda faqat statusni loading qilamiz (state.copyWith ichida)
        emit(state.copyWith(status: Status2.loading));
      }

      try {
        final int currentLength = event.isFetchMore
            ? (state.servicesData?.servicesModel?.length ?? 0)
            : 0;

        final int limit = 20; // Test uchun 2, production uchun 20

        final response = await _serviceRepo.getServices(
          skip: currentLength,
          limit: limit,
        );

        if (response.statusCode == 200) {
          final newServicesData = ServicesData.fromJson(response.data);

          if (newServicesData.success == true) {
            final List<ServicesModel> currentList = event.isFetchMore
                ? List<ServicesModel>.from(
                    state.servicesData?.servicesModel ?? [],
                  )
                : [];

            final List<ServicesModel> newList =
                newServicesData.servicesModel ?? [];

            // Agar kelgan ma'lumotlar limitdan kam bo'lsa, demak bu oxirgi sahifa
            final bool isLastPage = newList.length < limit;

            emit(
              state.copyWith(
                status: Status2.success,
                isLastPage: isLastPage,
                servicesData: ServicesData(
                  success: true,
                  servicesModel: [...currentList, ...newList],
                  message: newServicesData.message,
                  error: newServicesData.error,
                ),
              ),
            );
          } else {
            // Use mock data on API failure
            emit(
              state.copyWith(
                status: Status2.success,
                isLastPage: true,
                servicesData: MockData.services,
              ),
            );
          }
        }
      } on DioException catch (e) {
        // Use mock data on network error
        emit(
          state.copyWith(
            status: Status2.success,
            isLastPage: true,
            servicesData: MockData.services,
          ),
        );
      } catch (e) {
        // Use mock data on any error
        emit(
          state.copyWith(
            status: Status2.success,
            isLastPage: true,
            servicesData: MockData.services,
          ),
        );
      }
    });
  }
}
