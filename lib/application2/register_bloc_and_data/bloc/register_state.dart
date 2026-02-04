part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Status2 status;
  final String? errorMessage;
  final String? successMessage;
  final RegistrationModel? registrationModel;
  final User? user;

  const RegisterState({
    this.user,
    this.status = Status2.initial,
    this.errorMessage,
    this.successMessage,
    this.registrationModel,
  });

  RegisterState copyWith({
    User? user,
    Status2? status,
    String? errorMessage,
    String? successMessage,
    RegistrationModel? registrationModel,
  }) {
    return RegisterState(
      user: user ?? this.user,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      registrationModel: registrationModel ?? this.registrationModel,
    );
  }

  @override
  List<Object?> get props => [
    user,
    status,
    errorMessage,
    successMessage,
    registrationModel,
  ];
}
