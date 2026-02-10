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

class GetUserProfileEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class VisiteGuestEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class LoadUserFromSharedPrefsEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class UpdateTokenModelEvent extends RegisterEvent {
  final TokenModel tokenModel;
  const UpdateTokenModelEvent(this.tokenModel);
  @override
  List<Object?> get props => [tokenModel];
}

class UbdateUserProfile extends RegisterEvent {
  final String? firstName;
  final String? lastName;
  final String? gmail;
  const UbdateUserProfile(this.firstName, this.lastName, this.gmail);
  @override
  List<Object?> get props => [firstName, lastName, gmail];
}



