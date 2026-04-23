class ReviewListResponse {
  final bool? success;
  final List<ReviewData>? data;
  final String? message;
  final dynamic error;
  final int? total;
  final int? skip;
  final int? limit;

  ReviewListResponse({
    this.success,
    this.data,
    this.message,
    this.error,
    this.total,
    this.skip,
    this.limit,
  });

  factory ReviewListResponse.fromJson(Map<String, dynamic> json) =>
      ReviewListResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<ReviewData>.from(
                json["data"].map((x) => ReviewData.fromJson(x)),
              ),
        message: json["message"],
        error: json["error"],
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );
}

class ReviewData {
  final String? id;
  final String? bookingId;
  final String? userId;
  final String? serviceId;
  final String? masterId;
  final String? providerId;
  final int? rating;
  final String? comment;
  final String? providerResponse;
  final bool? isVisible;
  final String? createdAt;
  final String? updatedAt;
  final bool? isFlagged;
  final String? moderationStatus;
  final ReviewUser? user;
  final ReviewService? service;
  final ReviewProvider? provider;
  final String? userName;
  final String? userAvatar;
  final String? serviceTitle;
  final String? providerName;
  final String? providerLogo;

  ReviewData({
    this.id,
    this.bookingId,
    this.userId,
    this.serviceId,
    this.masterId,
    this.providerId,
    this.rating,
    this.comment,
    this.providerResponse,
    this.isVisible,
    this.createdAt,
    this.updatedAt,
    this.isFlagged,
    this.moderationStatus,
    this.user,
    this.service,
    this.provider,
    this.userName,
    this.userAvatar,
    this.serviceTitle,
    this.providerName,
    this.providerLogo,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        serviceId: json["service_id"],
        masterId: json["master_id"],
        providerId: json["provider_id"],
        rating: json["rating"],
        comment: json["comment"],
        providerResponse: json["provider_response"],
        isVisible: json["is_visible"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isFlagged: json["is_flagged"],
        moderationStatus: json["moderation_status"],
        user: json["user"] == null
            ? null
            : ReviewUser.fromJson(json["user"]),
        service: json["service"] == null
            ? null
            : ReviewService.fromJson(json["service"]),
        provider: json["provider"] == null
            ? null
            : ReviewProvider.fromJson(json["provider"]),
        userName: json["user_name"],
        userAvatar: json["user_avatar"],
        serviceTitle: json["service_title"],
        providerName: json["provider_name"],
        providerLogo: json["provider_logo"],
      );
}

class ReviewUser {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;

  ReviewUser({this.id, this.firstName, this.lastName, this.avatarUrl});

  factory ReviewUser.fromJson(Map<String, dynamic> json) => ReviewUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatarUrl: json["avatar_url"],
      );
}

class ReviewService {
  final String? id;
  final String? titleUz;
  final String? titleRu;
  final String? titleEn;

  ReviewService({this.id, this.titleUz, this.titleRu, this.titleEn});

  factory ReviewService.fromJson(Map<String, dynamic> json) => ReviewService(
        id: json["id"],
        titleUz: json["title_uz"],
        titleRu: json["title_ru"],
        titleEn: json["title_en"],
      );
}

class ReviewProvider {
  final String? id;
  final String? name;
  final String? logoUrl;

  ReviewProvider({this.id, this.name, this.logoUrl});

  factory ReviewProvider.fromJson(Map<String, dynamic> json) => ReviewProvider(
        id: json["id"],
        name: json["name"],
        logoUrl: json["logo_url"],
      );
}
