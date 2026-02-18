class DetailsServiceModel {
  final bool? success;
  final ServiceData? data;
  final String? message;
  final dynamic error;

  DetailsServiceModel({this.success, this.data, this.message, this.error});

  factory DetailsServiceModel.fromJson(Map<String, dynamic> json) =>
      DetailsServiceModel(
        success: json["success"],
        data: json["data"] == null ? null : ServiceData.fromJson(json["data"]),
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

class ServiceData {
  final String? id;
  final String? providerId;
  final String? categoryId;
  final String? titleUz;
  final String? titleRu;
  final String? titleEn;
  final String? descriptionUz;
  final String? descriptionRu;
  final String? descriptionEn;
  final String? basePrice;
  final String? maxPrice;
  final String? status;
  final double? averageRating;
  final int? totalBookings;
  final int? totalReviews;
  final ServiceCategory? category;
  final List<ServiceImage>? images;
  final ServiceProvider? provider;
  final String? currencyCode;
  final String? currencySymbol;

  ServiceData({
    this.id,
    this.providerId,
    this.categoryId,
    this.titleUz,
    this.titleRu,
    this.titleEn,
    this.descriptionUz,
    this.descriptionRu,
    this.descriptionEn,
    this.basePrice,
    this.maxPrice,
    this.status,
    this.averageRating,
    this.totalBookings,
    this.totalReviews,
    this.category,
    this.images,
    this.provider,
    this.currencyCode,
    this.currencySymbol,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    id: json["id"],
    providerId: json["provider_id"],
    categoryId: json["category_id"],
    titleUz: json["title_uz"],
    titleRu: json["title_ru"],
    titleEn: json["title_en"],
    descriptionUz: json["description_uz"],
    descriptionRu: json["description_ru"],
    descriptionEn: json["description_en"],
    basePrice: json["base_price"],
    maxPrice: json["max_price"],
    status: json["status"],
    averageRating: json["average_rating"]?.toDouble(),
    totalBookings: json["total_bookings"],
    totalReviews: json["total_reviews"],
    category: json["category"] == null
        ? null
        : ServiceCategory.fromJson(json["category"]),
    images: json["images"] == null
        ? null
        : List<ServiceImage>.from(
            json["images"].map((x) => ServiceImage.fromJson(x)),
          ),
    provider: json["provider"] == null
        ? null
        : ServiceProvider.fromJson(json["provider"]),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "category_id": categoryId,
    "title_uz": titleUz,
    "title_ru": titleRu,
    "title_en": titleEn,
    "description_uz": descriptionUz,
    "description_ru": descriptionRu,
    "description_en": descriptionEn,
    "base_price": basePrice,
    "max_price": maxPrice,
    "status": status,
    "average_rating": averageRating,
    "total_bookings": totalBookings,
    "total_reviews": totalReviews,
    "category": category?.toJson(),
    "images": images == null
        ? null
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "provider": provider?.toJson(),
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
  };
}

class ServiceCategory {
  final String? id;
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final String? iconUrl;
  final String? parentId;

  ServiceCategory({
    this.id,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.iconUrl,
    this.parentId,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      ServiceCategory(
        id: json["id"],
        nameUz: json["name_uz"],
        nameRu: json["name_ru"],
        nameEn: json["name_en"],
        iconUrl: json["icon_url"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_uz": nameUz,
    "name_ru": nameRu,
    "name_en": nameEn,
    "icon_url": iconUrl,
    "parent_id": parentId,
  };
}

class ServiceImage {
  final String? id;
  final String? imageUrl;
  final bool? isPrimary;

  ServiceImage({this.id, this.imageUrl, this.isPrimary});

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
    id: json["id"],
    imageUrl: json["image_url"],
    isPrimary: json["is_primary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "is_primary": isPrimary,
  };
}

class ServiceProvider {
  final String? id;
  final String? name;
  final String? logoUrl;
  final bool? isVerified;

  ServiceProvider({this.id, this.name, this.logoUrl, this.isVerified});

  factory ServiceProvider.fromJson(Map<String, dynamic> json) =>
      ServiceProvider(
        id: json["id"],
        name: json["name"],
        logoUrl: json["logo_url"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo_url": logoUrl,
    "is_verified": isVerified,
  };
}
