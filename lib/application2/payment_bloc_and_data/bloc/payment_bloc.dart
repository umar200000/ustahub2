import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
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
  }

  Future<void> _onCreatePayment(
    CreatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: Status2.loading));

    try {
      final response = await _paymentRepo.createPayment(
        bookingId: event.bookingId,
        paymentProvider: event.paymentProvider,
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

  Future<void> _onGetDetail(
    GetPaymentDetailEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(detailStatus: Status2.loading));

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
