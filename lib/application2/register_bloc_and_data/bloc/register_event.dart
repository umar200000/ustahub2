part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class CompleteRegistrationEvent extends RegisterEvent {
  final String phone;
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  const CompleteRegistrationEvent({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
  });

  @override
  List<Object?> get props => [phone, firstName, lastName, dateOfBirth];
}

class LoadUserFromSharedPrefsEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
