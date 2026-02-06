part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Status2 status;
  final String? errorMessage;
  final String? successMessage;
  final RegistrationModel? registrationModel;
  final TokenModel? tokenModel;
  final Status2 statusUser;
  final String? errorMessageUser;
  final String? successMessageUser;
  final UserProfile? userProfile;

  const RegisterState({
    this.tokenModel,
    this.status = Status2.initial,
    this.errorMessage,
    this.successMessage,
    this.registrationModel,
    this.statusUser = Status2.initial,
    this.errorMessageUser,
    this.successMessageUser,
    this.userProfile,
  });

  RegisterState copyWith({
    TokenModel? tokenModel,
    Status2? status,
    String? errorMessage,
    String? successMessage,
    RegistrationModel? registrationModel,
    Status2? statusUser,
    String? errorMessageUser,
    String? successMessageUser,
    UserProfile? userProfile,
  }) {
    return RegisterState(
      userProfile: userProfile ?? this.userProfile,
      statusUser: statusUser ?? this.statusUser,
      errorMessageUser: errorMessageUser ?? this.errorMessageUser,
      successMessageUser: successMessageUser ?? this.successMessageUser,
      tokenModel: tokenModel ?? this.tokenModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      registrationModel: registrationModel ?? this.registrationModel,
    );
  }

  @override
  List<Object?> get props => [
    userProfile,
    statusUser,
    errorMessageUser,
    successMessageUser,
    tokenModel,
    status,
    errorMessage,
    successMessage,
    registrationModel,
  ];
}
