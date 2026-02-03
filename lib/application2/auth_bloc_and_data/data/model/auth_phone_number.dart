class AuthPhoneNumber {
  final bool? success;
  final Data? data;
  final Error? error;
  final String? message;

  AuthPhoneNumber({this.success, this.data, this.error, this.message});

  factory AuthPhoneNumber.fromJson(Map<String, dynamic> json) =>
      AuthPhoneNumber(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "error": error?.toJson(),
    "message": message,
  };
}

class Data {
  final String? phone;
  final int? expiresInSeconds;
  final String? devNote;

  Data({this.phone, this.expiresInSeconds, this.devNote});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"],
    expiresInSeconds: json["expires_in_seconds"],
    devNote: json["dev_note"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "expires_in_seconds": expiresInSeconds,
    "dev_note": devNote,
  };
}

class Error {
  final String? code;
  final String? message;

  Error({this.code, this.message});

  factory Error.fromJson(Map<String, dynamic> json) =>
      Error(code: json["code"], message: json["message"]);

  Map<String, dynamic> toJson() => {"code": code, "message": message};
}
