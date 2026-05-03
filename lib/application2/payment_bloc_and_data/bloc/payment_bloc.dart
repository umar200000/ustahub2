import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/test_mode/test_mode_service.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/model/payment_model.dart';
import '../data/repo/payment_repo.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepo _paymentRepo = PaymentRepo();

  PaymentBloc() : super(const PaymentState()) {
    on<CreatePaymentEvent>(_onCreatePayment);
    on<GetPaymentHistoryEvent>(_onGetHistory);
    on<GetPaymentDetailEvent>(_onGetDetail);
    on<PreApplyPaymentEvent>(_onPreApply);
    on<ApplyPaymentEvent>(_onApply);
    on<ResetPaymentFlowEvent>(_onResetFlow);
  }

  void _onResetFlow(ResetPaymentFlowEvent event, Emitter<PaymentState> emit) {
    emit(const PaymentState());
  }

  Future<void> _onCreatePayment(
    CreatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: Status2.loading));

    // ── TEST REJIMI ── soxta paymentData yaratamiz, backend ga so'rov yo'q
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 500));
      final fakePaymentData = PaymentData(
        id: 'test-pay-${DateTime.now().millisecondsSinceEpoch}',
        bookingId: event.bookingId,
        paymentProvider: event.paymentProvider,
        status: 'pending',
      );
      emit(
        state.copyWith(
          status: Status2.success,
          paymentData: fakePaymentData,
          successMessage: "To'lov tayyorlandi",
        ),
      );
      return;
    }

    try {
      final response = await _paymentRepo.createPayment(
        bookingId: event.bookingId,
        paymentProvider: event.paymentProvider,
        cardId: event.cardId,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final isSuccess = responseData is Map<String, dynamic> &&
            responseData["success"] == true;

        if (isSuccess) {
          PaymentData? paymentData;
          try {
            paymentData = PaymentResponse.fromJson(responseData).data;
          } catch (_) {}
          emit(
            state.copyWith(
              status: Status2.success,
              paymentData: paymentData,
              successMessage: responseData["message"]?.toString(),
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: Status2.error,
              errorMessage: extractFromResponseData(responseData),
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
  }

  Future<void> _onGetHistory(
    GetPaymentHistoryEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(historyStatus: Status2.loading));

    // ── TEST REJIMI ── bo'sh ro'yxat
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(state.copyWith(historyStatus: Status2.success, historyItems: []));
      return;
    }

    try {
      final response = await _paymentRepo.getPaymentHistory();

      if (response.statusCode == 200) {
        final result = PaymentHistoryResponse.fromJson(response.data);

        if (result.success == true) {
          emit(
            state.copyWith(
              historyStatus: Status2.success,
              historyItems: result.data ?? [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              historyStatus: Status2.error,
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          historyStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          historyStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _onPreApply(
    PreApplyPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(preApplyStatus: Status2.loading));

    // ── TEST REJIMI ── soxta success
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 600));
      emit(
        state.copyWith(
          preApplyStatus: Status2.success,
          successMessage: "To'lov tasdiqlash uchun tayyor",
        ),
      );
      return;
    }

    try {
      final response = await _paymentRepo.preApplyPayment(
        paymentId: event.paymentId,
        cardId: event.cardId,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final isSuccess = responseData is Map<String, dynamic> &&
            responseData["success"] == true;

        if (isSuccess) {
          emit(
            state.copyWith(
              preApplyStatus: Status2.success,
              successMessage: responseData["message"]?.toString(),
            ),
          );
        } else {
          emit(
            state.copyWith(
              preApplyStatus: Status2.error,
              errorMessage: extractFromResponseData(responseData),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          preApplyStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          preApplyStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _onApply(
    ApplyPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(applyStatus: Status2.loading));

    // ── TEST REJIMI ── soxta success
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 600));
      emit(
        state.copyWith(
          applyStatus: Status2.success,
          successMessage: "To'lov muvaffaqiyatli amalga oshirildi",
        ),
      );
      return;
    }

    try {
      final response = await _paymentRepo.applyPayment(
        paymentId: event.paymentId,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final isSuccess = responseData is Map<String, dynamic> &&
            responseData["success"] == true;

        if (isSuccess) {
          emit(
            state.copyWith(
              applyStatus: Status2.success,
              successMessage: responseData["message"]?.toString(),
            ),
          );
        } else {
          emit(
            state.copyWith(
              applyStatus: Status2.error,
              errorMessage: extractFromResponseData(responseData),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          applyStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          applyStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }

  Future<void> _onGetDetail(
    GetPaymentDetailEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(detailStatus: Status2.loading));

    // ── TEST REJIMI ── bo'sh detail
    if (TestMode.isOn) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(state.copyWith(detailStatus: Status2.success));
      return;
    }

    try {
      final response = await _paymentRepo.getPaymentDetail(
        paymentId: event.paymentId,
      );

      if (response.statusCode == 200) {
        final result = PaymentDetailResponse.fromJson(response.data);

        if (result.success == true) {
          emit(
            state.copyWith(
              detailStatus: Status2.success,
              detailData: result.data,
            ),
          );
        } else {
          emit(
            state.copyWith(
              detailStatus: Status2.error,
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      }
    } on DioException catch (e) {
      emit(
        state.copyWith(
          detailStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailStatus: Status2.error,
          errorMessage: extractErrorMessage(e),
        ),
      );
    }
  }
}
