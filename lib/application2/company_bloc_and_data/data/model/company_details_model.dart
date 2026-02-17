class CompanyDetailsResponse {
  final bool? success;
  final CompanyDetailsData? data;
  final String? message;
  final dynamic error;

  CompanyDetailsResponse({this.success, this.data, this.message, this.error});

  factory CompanyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : CompanyDetailsData.fromJson(json["data"]),
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "error": error,
  };
}

class CompanyDetailsData {
  final String? id;
  final String? name;
  final String? slug;
  final String? logoUrl;
  final String? coverImageUrl;
  final String? description;
  final String? phone;
  final String? email;
  final String? website;
  final bool? isVerified;
  final dynamic rating;
  final int? totalServices;
  final int? totalMasters;
  final String? createdAt;

  CompanyDetailsData({
    this.id,
    this.name,
    this.slug,
    this.logoUrl,
    this.coverImageUrl,
    this.description,
    this.phone,
    this.email,
    this.website,
    this.isVerified,
    this.rating,
    this.totalServices,
    this.totalMasters,
    this.createdAt,
  });

  factory CompanyDetailsData.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        logoUrl: json["logo_url"],
        coverImageUrl: json["cover_image_url"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        website: json["website"],
        isVerified: json["is_verified"],
        rating: json["rating"],
        totalServices: json["total_services"],
        totalMasters: json["total_masters"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
    "description": description,
    "phone": phone,
    "email": email,
    "website": website,
    "is_verified": isVerified,
    "rating": rating,
    "total_services": totalServices,
    "total_masters": totalMasters,
    "created_at": createdAt,
  };
}
