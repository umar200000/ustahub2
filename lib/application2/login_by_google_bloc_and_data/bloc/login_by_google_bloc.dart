import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_by_google_event.dart';
part 'login_by_google_state.dart';

class LoginByGoogleBloc extends Bloc<LoginByGoogleEvent, LoginByGoogleState> {
  LoginByGoogleBloc() : super(LoginByGoogleInitial()) {
    on<LoginByGoogleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
