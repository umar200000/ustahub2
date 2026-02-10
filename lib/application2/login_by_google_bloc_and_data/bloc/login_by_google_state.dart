part of 'login_by_google_bloc.dart';

sealed class LoginByGoogleState extends Equatable {
  const LoginByGoogleState();
}

final class LoginByGoogleInitial extends LoginByGoogleState {
  @override
  List<Object> get props => [];
}
