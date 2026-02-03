import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ustahub/application2/auth_bloc_and_data/data/model/verify_otp_response.dart';
import 'package:ustahub/application2/auth_bloc_and_data/data/repo/auth_repo.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';

// Events
abstract class AuthPinPutEvent extends Equatable {
  const AuthPinPutEvent();
  @override
  List<Object?> get props => [];
}

class VerifyOtpEvent extends AuthPinPutEvent {
  final String phoneNumber;
  final String code;
  const VerifyOtpEvent({required this.phoneNumber, required this.code});
  @override
  List<Object?> get props => [phoneNumber, code];
}

// State
class AuthPinPutState extends Equatable {
  final Status2 status;
  final VerifyOtpResponse? verifyResponse;
  final String? errorMessage;

  const AuthPinPutState({
    this.status = Status2.initial,
    this.verifyResponse,
    this.errorMessage,
  });

  AuthPinPutState copyWith({
    Status2? status,
    VerifyOtpResponse? verifyResponse,
    String? errorMessage,
  }) {
    return AuthPinPutState(
      status: status ?? this.status,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, verifyResponse, errorMessage];
}

// Bloc
class AuthPinPutBloc extends Bloc<AuthPinPutEvent, AuthPinPutState> {
  final AuthRepo _authRepo = AuthRepo();

  AuthPinPutBloc() : super(const AuthPinPutState()) {
    on<VerifyOtpEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));

      try {
        final response = await _authRepo.verifyOtp(
          event.phoneNumber,
          event.code,
        );

        if (response.statusCode == 200) {
          final verifyData = VerifyOtpResponse.fromJson(response.data);

          if (verifyData.success == true) {
            emit(
              state.copyWith(
                status: Status2.success,
                verifyResponse: verifyData,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: Status2.error,
                errorMessage: verifyData.error?.message ?? "Kod xato kiritildi",
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
            status: Status2.error,
            errorMessage: serverErrorMessage ?? e.message ?? "Tarmoq xatoligi",
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: "Kutilmagan xatolik",
          ),
        );
      }
    });
  }
}
