import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../infrastructure/services/enum_status/status_enum.dart';
import '../../../infrastructure/services/shared_perf/shared_pref_service.dart';
import '../data/model/register_model.dart';
import '../data/repo/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _registerRepo = RegisterRepo();
  final SharedPrefService _prefService;

  RegisterBloc(this._prefService) : super(const RegisterState()) {
    on<CompleteRegistrationEvent>((event, emit) async {
      emit(state.copyWith(status: Status2.loading));
      try {
        final data = await _registerRepo.completeRegistration(
          phone: event.phone,
          firstName: event.firstName,
          lastName: event.lastName,
          dateOfBirth: event.dateOfBirth,
        );

        print("Response data: $data");

        if (data["success"] == true) {
          final user = User(
            dateOfBirth: DateFormat("yyyy-MM-dd").parse(event.dateOfBirth),
            firstName: event.firstName,
            lastName: event.lastName,
            phone: event.phone,
            tokenType: data["data"]["token_type"],
            userType: data["data"]["user_type"],
            refreshToken: data["data"]["refresh_token"],
            accessToken: data["data"]["access_token"],
          );

          _prefService.setUser(user);
          if (user.accessToken != null) {
            _prefService.setToken(user.accessToken!);
          }

          emit(
            state.copyWith(
              status: Status2.success,
              registrationModel: RegistrationModel.fromJson(data),
              user: user,
            ),
          );
        } else {
          // Backenddan success: false kelsa, shu yerga tushadi (400 error bo'lsa ham)
          String errorMessage = "Xatolik yuz berdi";
          if (data["error"] != null && data["error"]["message"] != null) {
            errorMessage = data["error"]["message"];
          } else if (data["message"] != null) {
            errorMessage = data["message"];
          }

          emit(
            state.copyWith(status: Status2.error, errorMessage: errorMessage),
          );
        }
      } catch (e) {
        // Faqat kutilmagan xatolar (internet yo'qligi va h.k.) uchun
        emit(
          state.copyWith(
            status: Status2.error,
            errorMessage: "Kutilmagan xatolik yuz berdi: $e",
          ),
        );
      }
    });

    on<LoadUserFromSharedPrefsEvent>((event, emit) async {
      final user = _prefService.getUser();
      if (user != null) {
        emit(state.copyWith(user: user));
      }
    });

    on<LogoutEvent>((event, emit) async {
      _prefService.clear();
      emit(
        state.copyWith(
          user: null,
          registrationModel: null,
          status: Status2.initial,
        ),
      );
    });
  }
}
