part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class EnterPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;
  const EnterPhoneNumberEvent({required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}
