import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/shared_perf/shared_pref_service.dart';
import '../../../infrastructure/services/test_mode/test_mode_service.dart';
import '../../../infrastructure2/common/error_helper.dart';
import '../data/model/profile_model.dart';
import '../data/model/register_model.dart';
import '../data/repo/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _registerRepo = RegisterRepo();
  final SharedPrefService _prefService;

  RegisterBloc(this._prefService) : super(const RegisterState()) {
    on<UpdateTokenModelEvent>((event, emit) {
      _prefService.setTokenModel(event.tokenModel);
      emit(state.copyWith(tokenModel: event.tokenModel));
    });

    on<GetLocalUserEvent>((event, emit) {
      final user = _prefService.getUserProfile();
      emit(state.copyWith(userProfile: user));
    });

    on<GetTokenEvent>((event, emit) async {
      try {
        // final data = await _registerRepo.getToken(
        //   refreshToken: event.refreshToken,
        // );

        if (event.data != null && event.data!["success"] == true) {
          final tokenModel = TokenModel(
            tokenType: event.data!["data"]["token_type"],
            userType: event.data!["data"]["user_type"],
            refreshToken: event.data!["data"]["refresh_token"],
            accessToken: event.data!["data"]["access_token"],
          );

          _prefService.setTokenModel(tokenModel);

          emit(
            state.copyWith(
              registrationModel: RegistrationModel.fromJson(event.data!),
              tokenModel: tokenModel,
            ),
          );
        } else {
          emit(
            state.copyWith(
              errorMessage: extractFromResponseData(event.data),
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(errorMessage: extractErrorMessage(e)));
      }
    });

    on<VisiteGuestEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));
      try {
        final data = await _registerRepo.visiteGuest();

        if (data["success"] == true) {
          final tokenModel = TokenModel(
            tokenType: data["data"]["token_type"],
            userType: data["data"]["user_type"],
            refreshToken: data["data"]["refresh_token"],
            accessToken: data["data"]["access_token"],
          );

          _prefService.setTokenModel(tokenModel);

          emit(
            state.copyWith(
              status: Status2.success,
              registrationModel: RegistrationModel.fromJson(data),
              tokenModel: tokenModel,
            ),
          );
        } else {
          // Navigate to main even if backend fails
          emit(state.copyWith(status: Status2.success));
        }
      } catch (e) {
        // Navigate to main even on timeout/error
        emit(state.copyWith(status: Status2.success));
      }
    });

    on<CompleteRegistrationEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));
      try {
        final data = await _registerRepo.completeRegistration(
          phone: event.phone,
          firstName: event.firstName,
          lastName: event.lastName,
          dateOfBirth: event.dateOfBirth,
        );

        if (data["success"] == true) {
          final tokenModel = TokenModel(
            tokenType: data["data"]["token_type"],
            userType: data["data"]["user_type"],
            refreshToken: data["data"]["refresh_token"],
            accessToken: data["data"]["access_token"],
          );

          _prefService.setTokenModel(tokenModel);
          add(GetUserProfileEvent());

          emit(
            state.copyWith(
              status: Status2.success,
              registrationModel: RegistrationModel.fromJson(data),
              tokenModel: tokenModel,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: Status2.error,
              errorMessage: extractFromResponseData(data),
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: Status2.error, errorMessage: extractErrorMessage(e)));
      }
    });

    on<GetUserProfileEvent>((event, emit) async {
      emit(state.copyWith(statusUser: Status2.loading));
      try {
        final data = await _registerRepo.getUserProfile();
        if (data["success"] == true) {
          final user = UserProfile.fromJson(data["data"]);

          await _prefService.setUserProfile(user);

          emit(
            state.copyWith(
              statusUser: Status2.success,
              userProfile: user,
              successMessageUser: data["message"],
            ),
          );
        } else {
          emit(
            state.copyWith(
              statusUser: Status2.error,
              errorMessageUser: extractFromResponseData(data),
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            statusUser: Status2.error,
            errorMessageUser: extractErrorMessage(e),
          ),
        );
      }
    });

    on<LoadUserFromSharedPrefsEvent>((event, emit) async {
      final tokenModel = _prefService.getTokenModel();
      final userProfile = _prefService.getUserProfile();

      emit(state.copyWith(tokenModel: tokenModel, userProfile: userProfile));
    });

    on<LogoutEvent>((event, emit) async {
      _prefService.clear();
      emit(const RegisterState());
    });

    on<UpdateUserProfile>((event, emit) async {
      emit(state.copyWith(statusUser: Status2.loading));

      // ── TEST REJIMI ── faqat lokal SharedPref ga yozamiz, backend yo'q
      if (TestMode.isOn) {
        await Future.delayed(const Duration(milliseconds: 300));
        final updatedUser = state.userProfile?.copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.gmail,
        );
        if (updatedUser != null) {
          await _prefService.setUserProfile(updatedUser);
        }
        emit(
          state.copyWith(
            statusUser: Status2.success,
            userProfile: updatedUser,
          ),
        );
        return;
      }

      try {
        final response = await _registerRepo.userProfileUbdate(
          firstName: event.firstName ?? "",
          lastName: event.lastName ?? "",
          email: event.gmail ?? "",
        );

        if (response['success'] == true) {
          final updatedUser = state.userProfile?.copyWith(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.gmail,
          );

          if (updatedUser != null) {
            await _prefService.setUserProfile(updatedUser);
          }

          emit(
            state.copyWith(
              statusUser: Status2.success,
              userProfile: updatedUser,
            ),
          );
        } else {
          emit(
            state.copyWith(
              statusUser: Status2.error,
              errorMessage: extractFromResponseData(response),
            ),
          );
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
            statusUser: Status2.error,
            errorMessage: extractErrorMessage(e),
          ),
        );
      }
    });
  }
}
