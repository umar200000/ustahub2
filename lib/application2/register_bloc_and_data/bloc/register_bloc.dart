import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/shared_perf/shared_pref_service.dart';
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
          String errorMessage = "Xatolik yuz berdi";
          if (data["error"] != null && data["error"]["message"] != null) {
            errorMessage = data["error"]["message"];
          }
          emit(
            state.copyWith(status: Status2.error, errorMessage: errorMessage),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: "Kutilmagan xatolik: $e",
          ),
        );
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

          add(GetUserProfileEvent()); // To'g'ridan-to'g'ri chaqirish

          emit(
            state.copyWith(
              status: Status2.success,
              registrationModel: RegistrationModel.fromJson(data),
              tokenModel: tokenModel,
            ),
          );
        } else {
          String errorMessage = "Xatolik yuz berdi";
          if (data["error"] != null && data["error"]["message"] != null) {
            errorMessage = data["error"]["message"];
          }
          emit(
            state.copyWith(status: Status2.error, errorMessage: errorMessage),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: "Kutilmagan xatolik: $e",
          ),
        );
      }
    });

    on<GetUserProfileEvent>((event, emit) async {
      emit(state.copyWith(statusUser: Status2.loading));
      try {
        final data = await _registerRepo.getUserProfile();
        if (data["success"] == true) {
          // status emas, success bo'lishi mumkin, tekshiring
          final user = UserProfile.fromJson(data["data"]);
          emit(
            state.copyWith(
              statusUser: Status2.success,
              userProfile: user,
              successMessageUser: data["message"],
            ),
          );
        } else {
          String errorMessage = "Profilni yuklab bo'lmadi";
          if (data["error"] != null && data["error"]["message"] != null) {
            errorMessage = data["error"]["message"];
          }
          emit(
            state.copyWith(
              statusUser: Status2.error,
              errorMessageUser: errorMessage,
            ),
          );
        }
      } on DioException catch (e) {
        String errorMessage = "Tarmoq xatoligi";
        if (e.response?.data != null && e.response?.data["error"] != null) {
          errorMessage = e.response?.data["error"]["message"];
        }
        emit(
          state.copyWith(
            statusUser: Status2.error,
            errorMessageUser: errorMessage,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            statusUser: Status2.error,
            errorMessageUser: "Kutilmagan xatolik: $e",
          ),
        );
      }
    });

    on<LoadUserFromSharedPrefsEvent>((event, emit) async {
      final tokenModel = _prefService.getTokenModel();
      if (tokenModel != null) {
        emit(state.copyWith(tokenModel: tokenModel));
      }
    });

    on<LogoutEvent>((event, emit) async {
      _prefService.clear();
      emit(
        state.copyWith(
          tokenModel: null,
          registrationModel: null,
          userProfile: null,
          status: Status2.initial,
          statusUser: Status2.initial,
        ),
      );
    });
  }
}
