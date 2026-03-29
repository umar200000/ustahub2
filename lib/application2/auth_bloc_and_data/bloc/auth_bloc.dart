import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ustahub/application2/auth_bloc_and_data/data/model/auth_phone_number.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo = AuthRepo();

  AuthBloc() : super(const AuthState()) {
    on<EnterPhoneNumberEvent>((event, emit) async {
      emit(state.copyWith(phoneStatus: Status2.loading));

      try {
        final response = await _authRepo.requestOtp(event.phoneNumber);

        if (response.data['success'] == true) {
          final authData = AuthPhoneNumber.fromJson(response.data);

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
              errorMessage: extractFromResponseData(response.data),
            ),
          );
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
            phoneStatus: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            phoneStatus: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      }
    });
  }
}
