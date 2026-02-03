part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Status2 phoneStatus;
  final AuthPhoneNumber? authPhoneNumber;
  final String? errorMessage;
  final String? successMessage;

  const AuthState({
    this.phoneStatus = Status2.initial,
    this.authPhoneNumber,
    this.errorMessage,
    this.successMessage,
  });

  AuthState copyWith({
    Status2? phoneStatus,
    AuthPhoneNumber? authPhoneNumber,
    String? errorMessage,
    String? successMessage,
  }) {
    return AuthState(
      phoneStatus: phoneStatus ?? this.phoneStatus,
      authPhoneNumber: authPhoneNumber ?? this.authPhoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    phoneStatus,
    authPhoneNumber,
    errorMessage,
    successMessage,
  ];
}
