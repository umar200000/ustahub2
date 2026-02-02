import 'dart:async';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustahub/domain/models/auth/auth.dart';
import 'package:ustahub/domain/models/main/main_model.dart';
import 'package:ustahub/domain/models/product/product_model.dart';
import 'package:ustahub/domain/models/success_model/success_model.dart';
import 'package:ustahub/domain/common/failure.dart';
import 'package:ustahub/infrastructure/repositories/Profile_repo.dart';
import 'package:ustahub/infrastructure/repositories/auth_repo.dart';
import 'package:ustahub/infrastructure/services/log_service.dart';
import 'package:ustahub/presentation/components/easy_loading.dart';
import 'package:ustahub/presentation/pages/main/components/updater_sheet.dart';
import 'package:ustahub/utils/constants.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final AuthRepository _authRepository;

  ProfileBloc(this._repository, this._authRepository)
    : super(const _ProfileState()) {
    on<_AddProduct>(_addProduct);
    on<_CreateProduct>(_createProduct);
    on<_GetProducts>(_getProducts);
    on<_ClearProducts>(_clearProducts);
    on<_GetProfile>(_getProfile);
    on<_GetTopItems>(_getTopItems);
    on<_GetRecommendation>(_getRecommendation);
    on<_PromocodeValidate>(_promocodeValidate);
    on<_ClearPromocode>(_clearPromocode);
    on<_PutOrder>(_putOrder);
    on<_ProfileUpdate>(_profileUpdate);
    on<_AddressAdd>(_addressAdd);
    on<_AddressUpdate>(_addressUpdate);
    on<_AddressRetrieve>(_addressRetrieve);
    on<_Status>(_status);
    on<_GetHistory>(_getHistory);
    on<_GetActiveList>(_getActiveList);
    on<_GetDraftCheckAvailability>(_getDraftCheckAvailability);
    on<_GetOrderItem>(_getOrderItem);
    on<_CreateCard>(_createCard);
    on<_VerifyCard>(_verifyCard);
    on<_UpdateTopUp>(_updateTopUp);
    on<_UpdateAddressTopUp>(_updateAddressTopUp);
    on<_PostSubscriptionCreate>(_postSubscriptionCreate);
    on<_DeleteProfile>(_deleteProfile);
    on<_GetPlannedSoon>(_getPlannedSoon);
    on<_DeleteAddress>(_deleteAddress);
    on<_DeleteCard>(_deleteCard);
    on<_ChangeLang>(_changeLang);
    on<_GetVersion>(_getVersion);
    on<_GetDeliveryPrice>(_getDeliveryPrice);
    on<_CreateFCMToken>(_createFCMToken);
    on<_PostRepeat>(_postRepeat);
    on<_GetPlannedOrderList>(_getPlannedOrderList);
    on<_GetPlannedOrderDetail>(_getPlannedOrderDetail);
    on<_ClearPlannedOrderDetail>(_clearPlannedOrderDetail);
    on<_CreatePlannedOrder>(_createPlannedOrder);
    on<_UpdatePlannedOrder>(_updatePlannedOrder);
    on<_AddToPlannedOrder>(_addToPlannedOrder);
    on<_UpdatePlannedOrderStatus>(_updatePlannedOrderStatus);
    on<_DeletePlannedOrder>(_deletePlannedOrder);
    on<_GetMonitoring>(_getMonitoring);
    on<_ChangePageStatus>(_changePageStatus);
    on<_RecreateState>(_recreateState);
    on<_UpdateImmediateState>(_updateImmediateState);
    on<_GetSectionList>(_getSectionList);
    on<_GetSectionById>(_getSectionById);
  }

  FutureOr<void> _recreateState(
    _RecreateState event,
    Emitter<ProfileState> emit,
  ) async {
    if (event.state != null) {
      emit(event.state!);
    }
  }

  FutureOr<void> _addProduct(
    _AddProduct event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusDraft: FormzSubmissionStatus.inProgress));

    // Create a copy of the current draft list to avoid mutation issues
    final List<ProductModel> currentDraftList = List.from(state.draftList);

    // Find the index of the product if it already exists
    final existingProductIndex = currentDraftList.indexWhere(
      (value) => value.id == event.product.id,
    );

    List<ProductModel> updatedDraftList;
    double totalAmount;
    double previousTotalAmount;

    if (existingProductIndex >= 0) {
      // Product exists - update it atomically
      updatedDraftList = List.from(currentDraftList);

      if (event.product.count != null && event.product.count! > 0) {
        // Update existing product
        updatedDraftList[existingProductIndex] = event.product;
      } else {
        // Remove product if count is 0 or negative
        updatedDraftList.removeAt(existingProductIndex);
      }
    } else {
      // Product doesn't exist - add it if count > 0
      if (event.product.count != null && event.product.count! > 0) {
        updatedDraftList = [...currentDraftList, event.product];
      } else {
        // Don't add products with 0 or negative count
        updatedDraftList = currentDraftList;
      }
    }

    // Calculate totals atomically
    totalAmount = updatedDraftList.fold<double>(
      0,
      (sum, product) => sum + ((product.price ?? 0) * (product.count ?? 0)),
    );

    previousTotalAmount = updatedDraftList.fold<double>(
      0,
      (sum, product) =>
          sum + ((product.previousPrice ?? 0) * (product.count ?? 0)),
    );

    // Emit the new state atomically
    emit(
      state.copyWith(
        draftList: updatedDraftList,
        totalAmount: totalAmount,
        previousTotalAmount: previousTotalAmount,
        statusDraft: FormzSubmissionStatus.success,
      ),
    );

    // Call the completion callback
    event.onLogicComplete(updatedDraftList, totalAmount);
  }

  FutureOr<void> _updateImmediateState(
    _UpdateImmediateState event,
    Emitter<ProfileState> emit,
  ) async {
    // Calculate previous total amount
    final previousTotalAmount = event.draftList.fold<double>(
      0.0,
      (sum, product) =>
          sum + ((product.previousPrice ?? 0) * (product.count ?? 0)),
    );

    // Emit immediate state update for UI dependencies
    emit(
      state.copyWith(
        draftList: event.draftList,
        totalAmount: event.totalAmount,
        previousTotalAmount: previousTotalAmount,
        statusDraft: event.isInProgress
            ? FormzSubmissionStatus.inProgress
            : FormzSubmissionStatus.success,
      ),
    );
  }

  FutureOr<void> _createProduct(
    _CreateProduct event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusDraft: FormzSubmissionStatus.inProgress));

    final res = await _repository.postOrderCreate(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusDraft: FormzSubmissionStatus.failure));
      },
      (data) {
        final draftList = data.orderThrought?.toList() ?? state.draftList;

        final totalAmount = draftList.fold<double>(
          0,
          (sum, product) => sum + ((product.price ?? 1) * (product.count ?? 1)),
        );
        final previousTotalAmount = draftList.fold<double>(
          0,
          (sum, product) =>
              sum + ((product.previousPrice ?? 1) * (product.count ?? 1)),
        );

        emit(
          state.copyWith(
            draftList: draftList,
            totalAmount: totalAmount,
            previousTotalAmount: previousTotalAmount,
            draftId: data.id,
            statusDraft: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _clearProducts(
    _ClearProducts event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusDraft: FormzSubmissionStatus.inProgress));

    final res = await _repository.postOrderCreate(
      request: OrderReq(
        (b) => b
          ..status = "draft"
          ..totalAmount = 0
          ..products = ListBuilder([]),
      ),
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusDraft: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            draftList: [],
            totalAmount: 0,
            previousTotalAmount: 0,
            statusDraft: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getProducts(
    _GetProducts event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.draftList.isEmpty) {
      emit(state.copyWith(statusDraft: FormzSubmissionStatus.inProgress));
    }

    final res = await _repository.getDraft();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusDraft: FormzSubmissionStatus.failure));
      },
      (data) {
        final List<ProductModel> draftList = List.from(
          data.orderThrought?.toList() ?? state.draftList,
        );
        double totalAmount = 0;
        double previousTotalAmount = 0;

        for (int i = 0; i < draftList.length; i++) {
          totalAmount += (draftList[i].price ?? 1) * (draftList[i].count ?? 1);
          previousTotalAmount +=
              (draftList[i].previousPrice ?? 1) * (draftList[i].count ?? 1);
        }

        final isFirstOrder = data.isFirstOrder ?? false;

        emit(
          state.copyWith(
            draftList: draftList,
            totalAmount: totalAmount,
            previousTotalAmount: previousTotalAmount,
            draftId: data.id,
            statusDraft: FormzSubmissionStatus.success,
            isFirstOrder: isFirstOrder,
          ),
        );
      },
    );
  }

  FutureOr<void> _getProfile(
    _GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.profile == null) {
      emit(state.copyWith(statusProfile: FormzSubmissionStatus.inProgress));
    }
    final res = await _authRepository.getProfile();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        // Set status based on error type
        final status = error is InvalidCredentials
            ? FormzSubmissionStatus.canceled
            : FormzSubmissionStatus.failure;
        emit(state.copyWith(statusProfile: status));
      },
      (data) {
        emit(
          state.copyWith(
            profile: data,
            statusProfile: FormzSubmissionStatus.success,
          ),
        );
        // Call onDone callback if provided
        event.onDone?.call();
      },
    );
  }

  FutureOr<void> _getTopItems(
    _GetTopItems event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusTopItems: FormzSubmissionStatus.inProgress));

    final result = await _repository.getTopItems();

    result.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(state.copyWith(statusTopItems: FormzSubmissionStatus.failure));
      },
      (response) {
        final List<ProductModel> items = [];

        if (response.results != null) {
          items.addAll(response.results!.toList());
        }

        emit(
          state.copyWith(
            topItems: items,
            statusTopItems: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getRecommendation(
    _GetRecommendation event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusTopItems: FormzSubmissionStatus.inProgress));

    final result = await _repository.getRecommendation();

    result.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(state.copyWith(statusTopItems: FormzSubmissionStatus.failure));
      },
      (items) {
        emit(
          state.copyWith(
            topItems: items,
            statusTopItems: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _promocodeValidate(
    _PromocodeValidate event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusPromocde: FormzSubmissionStatus.inProgress));

    EasyLoading.show();

    final res = await _repository.promocodeValidate(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        emit(state.copyWith(statusPromocde: FormzSubmissionStatus.failure));
      },
      (data) {
        event.onDone();

        emit(
          state.copyWith(
            promocode: data,
            statusPromocde: FormzSubmissionStatus.success,
          ),
        );
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _clearPromocode(
    _ClearPromocode event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(promocode: null));
  }

  FutureOr<void> _putOrder(_PutOrder event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(statusOrder: FormzSubmissionStatus.inProgress));

    EasyLoading.show();

    final res = await _repository.putOrder(
      request: event.request,
      id: event.draftId,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        emit(state.copyWith(statusOrder: FormzSubmissionStatus.failure));
      },
      (data) {
        event.onDone();

        emit(state.copyWith(statusOrder: FormzSubmissionStatus.success));
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _profileUpdate(
    _ProfileUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    final res = await _authRepository.updateProfile(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
      },
      (data) {
        add(const ProfileEvent.getProfile());
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _addressAdd(
    _AddressAdd event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    final res = await _authRepository.addressAdd(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
      },
      (data) {
        add(const ProfileEvent.getProfile());
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _addressUpdate(
    _AddressUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    final res = await _authRepository.addressUpdate(
      id: event.id,
      request: event.request,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on address update: ${error.message}");
        EasyLoading.showError(error.message);
      },
      (data) {
        add(const ProfileEvent.getProfile());
        event.onDone();
        EasyLoading.showSuccess('address_updated'.tr());
      },
    );

    EasyLoading.dismiss();
  }

  FutureOr<void> _addressRetrieve(
    _AddressRetrieve event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    final res = await _authRepository.addressRetrieve(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on address retrieve: ${error.message}");
        EasyLoading.showError(error.message);
      },
      (address) {
        event.onSuccess(address);
      },
    );

    EasyLoading.dismiss();
  }

  FutureOr<void> _status(_Status event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(statusOrderStatus: FormzSubmissionStatus.inProgress));

    EasyLoading.show();

    final res = await _repository.status(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        emit(state.copyWith(statusOrderStatus: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusOrderStatus: FormzSubmissionStatus.success,
            statusModel: data,
          ),
        );
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _getHistory(
    _GetHistory event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _repository.getHistory();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        emit(state.copyWith(historyList: data));
      },
    );
  }

  FutureOr<void> _getActiveList(
    _GetActiveList event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusActiveList: FormzSubmissionStatus.inProgress));

    final res = await _repository.getActiveList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        emit(state.copyWith(statusActiveList: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            activeList: data,
            statusActiveList: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getDraftCheckAvailability(
    _GetDraftCheckAvailability event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _repository.getDraftCheckAvailability();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        event.onDone(data);
      },
    );
  }

  FutureOr<void> _postRepeat(
    _PostRepeat event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();
    final res = await _repository.postRepeat(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
      },
      (data) {
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _getOrderItem(
    _GetOrderItem event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusOrderItem: FormzSubmissionStatus.inProgress));

    EasyLoading.show();

    final res = await _repository.getOrderItem(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        emit(state.copyWith(statusOrderItem: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            statusOrderItem: FormzSubmissionStatus.success,
            orderModel: data,
          ),
        );
      },
    );

    EasyLoading.dismiss();
  }

  FutureOr<void> _createCard(
    _CreateCard event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    emit(state.copyWith(statusCard: FormzSubmissionStatus.inProgress));
    final res = await _repository.createCard(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        emit(state.copyWith(statusCard: FormzSubmissionStatus.failure));
      },
      (data) {
        event.onDone();
        emit(state.copyWith(statusCard: FormzSubmissionStatus.success));
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _verifyCard(
    _VerifyCard event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    emit(state.copyWith(statusCard: FormzSubmissionStatus.inProgress));
    final res = await _repository.verifyCard(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
        emit(state.copyWith(statusCard: FormzSubmissionStatus.failure));
      },
      (data) {
        event.onDone();
        emit(state.copyWith(statusCard: FormzSubmissionStatus.success));
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _updateTopUp(
    _UpdateTopUp event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();
    final res = await _authRepository.updateTopUp(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        add(const ProfileEvent.getProfile());
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _updateAddressTopUp(
    _UpdateAddressTopUp event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    final res = await _authRepository.updateAddressTopUp(
      request: event.request,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        add(const ProfileEvent.getProfile());
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _postSubscriptionCreate(
    _PostSubscriptionCreate event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();
    final res = await _repository.postSubscriptionCreate(
      request: event.request,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
      },
      (data) {
        event.onDone();
        EasyLoading.showSuccess('subscription_created'.tr());
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _deleteProfile(
    _DeleteProfile event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();
    final res = await _authRepository.deleteProfile();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
        EasyLoading.showError(error.message);
      },
      (data) {
        event.onDone();
        EasyLoading.showSuccess('profile_deleted'.tr());
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _getPlannedSoon(
    _GetPlannedSoon event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _repository.getPlannedSoon();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        emit(state.copyWith(plannedSoonModel: data));
      },
    );
  }

  FutureOr<void> _deleteAddress(
    _DeleteAddress event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();
    final res = await _authRepository.deleteAddress(id: event.id);

    res.fold(
      (error) {
        EasyLoading.showError(error.message);
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        add(ProfileEvent.getProfile());
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _deleteCard(
    _DeleteCard event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();
    final res = await _repository.deleteCard(id: event.id);

    res.fold(
      (error) {
        EasyLoading.showError(error.message);
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        event.onDone();
      },
    );
    EasyLoading.dismiss();
  }

  FutureOr<void> _changeLang(
    _ChangeLang event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(langChanged: !state.langChanged));
  }

  FutureOr<void> _getVersion(
    _GetVersion event,
    Emitter<ProfileState> emit,
  ) async {
    // final result = (await PackageInfo.fromPlatform());
    // if (!kDebugMode || result.version != '1.0.5') {
    //   final res = await _authRepository.getVersion();

    //   res.fold(
    //     (error) {
    //       LogService.e(" ----> error on bloc  : $error");
    //     },
    //     (data) async {
    //       // if (((data.android ?? "") != result.version && Platform.isAndroid) ||
    //       //     ((data.ios ?? "") != result.version && Platform.isIOS)) {
    //       EasyLoading.showWidget(
    //         builder:
    //             (context) => UpdaterSheet(
    //               onUpdate: () async {
    //                 final resSecond = await _authRepository.getVersion();

    //                 resSecond.fold(
    //                   (error) {
    //                     LogService.e(" ----> error on bloc  : $error");
    //                   },
    //                   (data) {
    //                     if (((data.android ?? "") != result.version && Platform.isAndroid) ||
    //                         ((data.ios ?? "") != result.version && Platform.isIOS)) {
    //                       if (Platform.isIOS) {
    //                         launchUrl(Uri.parse(Constants.appStoreUrl));
    //                       } else {
    //                         launchUrl(Uri.parse(Constants.googlePlayUrl));
    //                       }
    //                     } else {
    //                       SmartDialog.dismiss();
    //                     }
    //                   },
    //                 );
    //               },
    //             ),
    //         isDismissible: false,
    //       );
    //     },
    //     // },
    //   );
    // }
  }

  FutureOr<void> _getDeliveryPrice(
    _GetDeliveryPrice event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _repository.getDeliveryPrice(addressId: event.addressId);

    res.fold(
      (error) {
        LogService.e(" ----> error on getDeliveryPrice: $error");
      },
      (data) {
        emit(state.copyWith(deliveryPrices: data));

        // Call onDone after state is updated
        event.onDone?.call();
      },
    );
  }

  FutureOr<void> _createFCMToken(
    _CreateFCMToken event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _authRepository.createFCMToken(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc  : $error");
      },
      (data) {
        event.onDone();
      },
    );
  }

  FutureOr<void> _getPlannedOrderList(
    _GetPlannedOrderList event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusPlannedOrders: FormzSubmissionStatus.inProgress));

    final res = await _repository.getPlannedOrderList();

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        emit(
          state.copyWith(
            plannedOrders: data,
            statusPlannedOrders: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getPlannedOrderDetail(
    _GetPlannedOrderDetail event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        statusPlannedOrderDetail: FormzSubmissionStatus.inProgress,
      ),
    );

    final res = await _repository.getPlannedOrderDetail(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(
          state.copyWith(
            statusPlannedOrderDetail: FormzSubmissionStatus.failure,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            plannedOrderDetail: data,
            statusPlannedOrderDetail: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _clearPlannedOrderDetail(
    _ClearPlannedOrderDetail event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        plannedOrderDetail: null,
        statusPlannedOrderDetail: FormzSubmissionStatus.initial,
      ),
    );
  }

  FutureOr<void> _createPlannedOrder(
    _CreatePlannedOrder event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusPlannedOrders: FormzSubmissionStatus.inProgress));
    EasyLoading.show();

    final res = await _repository.createPlannedOrder(request: event.request);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        EasyLoading.showError(error.message);
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        EasyLoading.showSuccess('planned_order_created'.tr());

        event.onDone();
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.success),
        );

        Future.delayed(const Duration(seconds: 3), () {
          EasyLoading.dismiss();
        });
      },
    );
  }

  FutureOr<void> _updatePlannedOrder(
    _UpdatePlannedOrder event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusPlannedOrders: FormzSubmissionStatus.inProgress));
    EasyLoading.show();

    final res = await _repository.updatePlannedOrder(
      request: event.request,
      id: event.id,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        EasyLoading.showError(error.message);
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        EasyLoading.showSuccess('planned_order_updated'.tr());
        event.onDone();
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.success),
        );
      },
    );
  }

  FutureOr<void> _addToPlannedOrder(
    _AddToPlannedOrder event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusPlannedOrders: FormzSubmissionStatus.inProgress));
    EasyLoading.show();

    final res = await _repository.addToPlannedOrder(
      request: event.request,
      id: event.id,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        EasyLoading.showError(error.message);
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.failure),
        );
      },
      (data) {
        EasyLoading.showSuccess("product_added_to_planned_order".tr());
        event.onDone();
        emit(
          state.copyWith(statusPlannedOrders: FormzSubmissionStatus.success),
        );
      },
    );
  }

  FutureOr<void> _getMonitoring(
    _GetMonitoring event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusMonitoring: FormzSubmissionStatus.inProgress));

    final res = await _repository.getMonitoring(
      dateFrom: event.dateFrom,
      dateTo: event.dateTo,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(state.copyWith(statusMonitoring: FormzSubmissionStatus.failure));
      },
      (data) {
        emit(
          state.copyWith(
            monitoring: data,
            statusMonitoring: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _updatePlannedOrderStatus(
    _UpdatePlannedOrderStatus event,
    Emitter<ProfileState> emit,
  ) async {
    // Create a PlannedOrderModel with the status field set based on the isActive flag
    final requestModel = PlannedOrderModel(
      (b) => b..status = event.isActive ? 'active' : 'inactive',
    );

    final res = await _repository.updatePlannedOrderStatus(
      request: requestModel,
      id: event.id,
    );

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        EasyLoading.showError(error.message);
      },
      (data) {
        event.onDone();
      },
    );
  }

  FutureOr<void> _deletePlannedOrder(
    _DeletePlannedOrder event,
    Emitter<ProfileState> emit,
  ) async {
    EasyLoading.show();

    final res = await _repository.deletePlannedOrder(id: event.id);

    res.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        EasyLoading.showError(error.message);
      },
      (data) {
        EasyLoading.showSuccess('planned_order_deleted'.tr());
        event.onDone();
        // Refresh the planned order list after deletion
        add(const ProfileEvent.getPlannedOrderList());
      },
    );

    EasyLoading.dismiss();
  }

  FutureOr<void> _changePageStatus(
    _ChangePageStatus event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(currentPage: event.status));
  }

  FutureOr<void> _getSectionList(
    _GetSectionList event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(statusSections: FormzSubmissionStatus.inProgress));

    final result = await _repository.getSectionList();

    result.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(state.copyWith(statusSections: FormzSubmissionStatus.failure));
      },
      (sections) {
        emit(
          state.copyWith(
            sections: sections,
            statusSections: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }

  FutureOr<void> _getSectionById(
    _GetSectionById event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(statusCurrentSection: FormzSubmissionStatus.inProgress),
    );

    final result = await _repository.getSectionById(id: event.id);

    result.fold(
      (error) {
        LogService.e(" ----> error on bloc: ${error.message}");
        emit(
          state.copyWith(statusCurrentSection: FormzSubmissionStatus.failure),
        );
      },
      (section) {
        emit(
          state.copyWith(
            currentSection: section,
            statusCurrentSection: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }
}
