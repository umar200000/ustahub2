class BannerDetailsModel {
  final bool? success;
  final BannerDetailsData? data;
  final String? message;

  BannerDetailsModel({this.success, this.data, this.message});

  factory BannerDetailsModel.fromJson(Map<String, dynamic> json) =>
      BannerDetailsModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : BannerDetailsData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class BannerDetailsData {
  final String? id;
  final String? title; // Localized title from backend
  final String? subtitle; // Localized subtitle from backend
  final String? description; // Localized description from backend
  final String? imageUrl;

  // Fallback fields
  final String? titleUz;
  final String? titleRu;
  final String? titleEn;
  final String? subtitleUz;
  final String? subtitleRu;
  final String? subtitleEn;
  final String? descriptionUz;
  final String? descriptionRu;
  final String? descriptionEn;

  BannerDetailsData({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.imageUrl,
    this.titleUz,
    this.titleRu,
    this.titleEn,
    this.subtitleUz,
    this.subtitleRu,
    this.subtitleEn,
    this.descriptionUz,
    this.descriptionRu,
    this.descriptionEn,
  });

  factory BannerDetailsData.fromJson(Map<String, dynamic> json) =>
      BannerDetailsData(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        imageUrl: json["image_url"],
        titleUz: json["title_uz"],
        titleRu: json["title_ru"],
        titleEn: json["title_en"],
        subtitleUz: json["subtitle_uz"],
        subtitleRu: json["subtitle_ru"],
        subtitleEn: json["subtitle_en"],
        descriptionUz: json["description_uz"],
        descriptionRu: json["description_ru"],
        descriptionEn: json["description_en"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "image_url": imageUrl,
  };
}
