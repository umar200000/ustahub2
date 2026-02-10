part of 'login_by_google_bloc.dart';

class LoginByGoogleEvent extends Equatable {
  final String idToken;
  final String devicToken;
  final String devicType;
  const LoginByGoogleEvent({
    required this.idToken,
    required this.devicToken,
    required this.devicType,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [idToken, devicToken, devicType];
}
