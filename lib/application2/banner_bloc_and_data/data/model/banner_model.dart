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
  final String? title;
  final String? subtitle;
  final String? imageUrl;

  BannerData({this.id, this.title, this.subtitle, this.imageUrl});

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "image_url": imageUrl,
  };
}
