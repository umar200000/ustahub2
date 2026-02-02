import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ustahub/domain/models/home/home_model.dart';
import 'package:ustahub/domain/models/notification/notification_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/infrastructure/repositories/main_repo.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';

part 'main_bloc.freezed.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository _mainRepository;

  MainBloc(this._mainRepository) : super(const _MainState()) {
    on<_GetCurrency>(_getCurrency);
    on<_GetBannerList>(_getBannerList);
    on<_GetStoryList>(_getStoryList);
    on<_GetSetPackage>(_getSetPackage);
    on<_GetBrandShort>(_getBrandShort);
    on<_GetCountry>(_getCountry);
    on<_GetNotificationList>(_getNotificationList);
    on<_UpdateNotification>(_updateNotification);
    on<_GetInformList>(_getInformList);
    on<_GetTenantSetPackage>(_getTenantSetPackage);
    on<_GetTenantCategory>(_getTenantCategory);
  }

  FutureOr<void> _getCurrency(
    _GetCurrency event,
    Emitter<MainState> emit,
  ) async {
    final res = await _mainRepository.getCurrency();

    res.fold((error) {
      LogService.e(" ----> error on bloc  : $error");
    }, (data) {});
  }

  FutureOr<void> _getBannerList(
    _GetBannerList event,
    Emitter<MainState> emit,
  ) async {
    if (state.bannerList.isEmpty) {
      emit(state.copyWith(statusBanner: FormzSubmissionStatus.inProgress));
    }

    final res = await _mainRepository.getBannerList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusBanner: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusBanner: FormzSubmissionStatus.success,
            bannerList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getStoryList(
    _GetStoryList event,
    Emitter<MainState> emit,
  ) async {
    if (state.storyList.isEmpty) {
      emit(state.copyWith(statusStory: FormzSubmissionStatus.inProgress));
    }

    final res = await _mainRepository.getStoryList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusStory: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusStory: FormzSubmissionStatus.success,
            storyList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getSetPackage(
    _GetSetPackage event,
    Emitter<MainState> emit,
  ) async {
    if (state.setList.isEmpty) {
      emit(state.copyWith(statusSet: FormzSubmissionStatus.inProgress));
    }

    final res = await _mainRepository.getSetPackage();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusSet: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusSet: FormzSubmissionStatus.success,
            setList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTenantSetPackage(
    _GetTenantSetPackage event,
    Emitter<MainState> emit,
  ) async {
    if (state.setList.isEmpty) {
      emit(state.copyWith(statusSet: FormzSubmissionStatus.inProgress));
    }

    final res = await _mainRepository.getTenantSetPackage();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusSet: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusSet: FormzSubmissionStatus.success,
            tenantSetList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTenantCategory(
    _GetTenantCategory event,
    Emitter<MainState> emit,
  ) async {
    if (state.tenantCategoryList.isEmpty) {
      emit(
        state.copyWith(statusTenantCategory: FormzSubmissionStatus.inProgress),
      );
    }

    final res = await _mainRepository.getTenantCategory();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(
          state.copyWith(statusTenantCategory: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        emit(
          state.copyWith(
            statusTenantCategory: FormzSubmissionStatus.success,
            tenantCategoryList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getBrandShort(
    _GetBrandShort event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(statusBrand: FormzSubmissionStatus.inProgress));

    final countryId = event.countries?.join(',');
    // Use categoryId in the API call
    final categoryId = event.categoryId;

    final res = await _mainRepository.getBrandShort(
      countryId: countryId,
      categoryId: categoryId,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusBrand: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusBrand: FormzSubmissionStatus.success,
            brandList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getCountry(_GetCountry event, Emitter<MainState> emit) async {
    emit(state.copyWith(statusCountry: FormzSubmissionStatus.inProgress));
    // Use categoryId in the API call
    final categoryId = event.categoryId;

    final res = await _mainRepository.getCountry(categoryId: categoryId);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusCountry: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusCountry: FormzSubmissionStatus.success,
            countryList: data,
          ),
        );
      },
    );
  }

  FutureOr<void> _getNotificationList(
    _GetNotificationList event,
    Emitter<MainState> emit,
  ) async {
    if (state.notificationList.isEmpty) {
      emit(
        state.copyWith(statusNotification: FormzSubmissionStatus.inProgress),
      );
    }

    final res = await _mainRepository.getNotificationList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusNotification: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusNotification: FormzSubmissionStatus.success,
            notificationList: List.from(data.results?.toList() ?? []),
          ),
        );
      },
    );
  }

  FutureOr<void> _updateNotification(
    _UpdateNotification event,
    Emitter<MainState> emit,
  ) async {
    final res = await _mainRepository.updateNotification(
      id: event.id,
      body: NotificationModel((b) => b..isRead = true),
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        // After successful update, refresh the notification list
        add(const MainEvent.getNotificationList());
      },
    );
  }

  FutureOr<void> _getInformList(
    _GetInformList event,
    Emitter<MainState> emit,
  ) async {
    if (state.listInform.isEmpty) {
      emit(state.copyWith(statusInform: FormzSubmissionStatus.inProgress));
    }

    final res = await _mainRepository.getInformList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusInform: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusInform: FormzSubmissionStatus.success,
            listInform: List.from(data.results?.toList() ?? []),
          ),
        );
      },
    );
  }
}
