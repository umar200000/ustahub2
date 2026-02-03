import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ustahub/application2/auth_bloc_and_data/data/model/auth_phone_number.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../data/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo = AuthRepo();

  AuthBloc() : super(const AuthState()) {
    on<EnterPhoneNumberEvent>((event, emit) async {
      emit(state.copyWith(phoneStatus: Status2.loading));

      try {
        // Endi to'g'ridan-to'g'ri dio emas, repo orqali chaqiramiz
        final response = await _authRepo.requestOtp(event.phoneNumber);

        if (response.statusCode == 200) {
          final authData = AuthPhoneNumber.fromJson(response.data);

          if (authData.success == true) {
            emit(
              state.copyWith(
                phoneStatus: Status2.success,
                authPhoneNumber: authData,
                successMessage: authData.message,
              ),
            );
          } else {
            emit(
              state.copyWith(
                phoneStatus: Status2.error,
                errorMessage: authData.error?.message ?? "Xatolik yuz berdi",
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
            phoneStatus: Status2.error,
            errorMessage: serverErrorMessage ?? e.message ?? "Tarmoq xatoligi",
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            phoneStatus: Status2.error,
            errorMessage: "Kutilmagan xatolik: ${e.toString()}",
          ),
        );
      }
    });
  }
}
