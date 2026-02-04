import 'package:easy_localization/easy_localization.dart';

class RegistrationModel {
  final bool? success;
  final User? data;

  final String? message;

  RegistrationModel({this.success, this.data, this.message});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        success: json["success"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),

        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),

    "message": message,
  };
}

class User {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final String? userType;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;

  User({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.userType,
    this.phone,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    userType: json["user_type"],
    phone: json["phone"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dateOfBirth: json["date_of_birth"] == null
        ? null
        : DateFormat("yyyy-MM-dd").parse(json["date_of_birth"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "user_type": userType,
    "phone": phone,
    "first_name": firstName,
    "last_name": lastName,
    "date_of_birth": dateOfBirth == null
        ? null
        : DateFormat('yyyy-MM-dd').format(dateOfBirth!),
  };
}
