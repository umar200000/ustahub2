class RegistrationModel {
  final bool? success;
  final TokenModel? data;

  final String? message;

  RegistrationModel({this.success, this.data, this.message});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        success: json["success"],
        data: json["data"] == null ? null : TokenModel.fromJson(json["data"]),

        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),

    "message": message,
  };
}

class TokenModel {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final String? userType;

  TokenModel({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.userType,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "user_type": userType,
  };
}
