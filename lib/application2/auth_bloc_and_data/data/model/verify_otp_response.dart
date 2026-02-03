class VerifyOtpResponse {
  bool? success;
  Data? data;
  String? message;
  Error? error;

  VerifyOtpResponse({this.success, this.data, this.message, this.error});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }
}

class Data {
  bool? phoneVerified;
  bool? isExistingUser;
  String? message;

  Data({this.phoneVerified, this.isExistingUser, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    phoneVerified = json['phone_verified'];
    isExistingUser = json['is_existing_user'];
    message = json['message'];
  }
}

class Error {
  String? code;
  String? message;

  Error({this.code, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
