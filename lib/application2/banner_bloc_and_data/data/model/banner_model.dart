class BannerModel {
  final bool? success;
  final List<BannerData>? data;
  final String? message;
  final dynamic error;

  BannerModel({this.success, this.data, this.message, this.error});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    success: json["success"],
    data: json["data"] == null
        ? null
        : List<BannerData>.from(
            json["data"].map((x) => BannerData.fromJson(x)),
          ),
    message: json["message"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? null
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "error": error,
  };
}

class BannerData {
  final String? id;
  final String? titleUz;
  final String? titleRu;
  final String? titleEn;
  final String? subtitleUz;
  final String? subtitleRu;
  final String? subtitleEn;
  final String? imageUrl;

  BannerData({
    this.id,
    this.titleUz,
    this.titleRu,
    this.titleEn,
    this.subtitleUz,
    this.subtitleRu,
    this.subtitleEn,
    this.imageUrl,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["id"],
    // Backend "title_uz" yuborsa shuni oladi, aks holda eski "title"ni oladi
    titleUz: json["title_uz"] ?? json["title"],
    titleRu: json["title_ru"] ?? json["title"],
    titleEn: json["title_en"] ?? json["title"],
    subtitleUz: json["subtitle_uz"] ?? json["subtitle"],
    subtitleRu: json["subtitle_ru"] ?? json["subtitle"],
    subtitleEn: json["subtitle_en"] ?? json["subtitle"],
    imageUrl: json["image_url"] ?? json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_uz": titleUz,
    "title_ru": titleRu,
    "title_en": titleEn,
    "subtitle_uz": subtitleUz,
    "subtitle_ru": subtitleRu,
    "subtitle_en": subtitleEn,
    "image_url": imageUrl,
  };
}
