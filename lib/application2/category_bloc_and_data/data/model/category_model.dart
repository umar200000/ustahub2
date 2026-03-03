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
  final String? name;
  final String? iconUrl;
  final dynamic parentId;

  CategoryModel({this.id, this.name, this.iconUrl, this.parentId});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    iconUrl: json["icon_url"],
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon_url": iconUrl,
    "parent_id": parentId,
  };
}
