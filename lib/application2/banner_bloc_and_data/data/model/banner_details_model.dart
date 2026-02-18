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
  final String? title;
  final String? subtitle;
  final String? description;
  final String? imageUrl;

  BannerDetailsData({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.imageUrl,
  });

  factory BannerDetailsData.fromJson(Map<String, dynamic> json) =>
      BannerDetailsData(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "image_url": imageUrl,
  };
}
