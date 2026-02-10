class CategoryData {
  final bool? success;
  final List<CategoryModel>? categoryModel;
  final String? message;
  final dynamic error;

  CategoryData({this.success, this.categoryModel, this.message, this.error});

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    success: json["success"],
    categoryModel: json["data"] == null
        ? []
        : List<CategoryModel>.from(
            json["data"]!.map((x) => CategoryModel.fromJson(x)),
          ),
    message: json["message"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": categoryModel == null
        ? []
        : List<dynamic>.from(categoryModel!.map((x) => x.toJson())),
    "message": message,
    "error": error,
  };
}

class CategoryModel {
  final String? id;
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final String? iconUrl;
  final dynamic parentId;

  CategoryModel({
    this.id,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.iconUrl,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
