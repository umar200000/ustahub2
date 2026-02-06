class ProfileModel {
  final bool? success;
  final UserProfile? userProfile;
  final String? message;

  ProfileModel({this.success, this.userProfile, this.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    userProfile: json["userProfile"] == null
        ? null
        : UserProfile.fromJson(json["userProfile"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "userProfile": userProfile?.toJson(),
    "message": message,
  };
}

class UserProfile {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? userType;
  final String? phone;
  final String? email;
  final DateTime? createdAt;

  UserProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.userType,
    this.phone,
    this.email,
    this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userType: json["user_type"],
    phone: json["phone"],
    email: json["email"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "user_type": userType,
    "phone": phone,
    "email": email,
    "created_at": createdAt?.toIso8601String(),
  };
}
