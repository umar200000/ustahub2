class ServicesData {
  final bool? success;
  final List<ServicesModel>? servicesModel;
  final String? message;
  final dynamic error;

  ServicesData({this.success, this.servicesModel, this.message, this.error});

  factory ServicesData.fromJson(Map<String, dynamic> json) => ServicesData(
    success: json["success"],
    servicesModel: json["data"] == null
        ? []
        : List<ServicesModel>.from(
            json["data"]!.map((x) => ServicesModel.fromJson(x)),
          ),
    message: json["message"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": servicesModel == null
        ? []
        : List<dynamic>.from(servicesModel!.map((x) => x.toJson())),
    "message": message,
    "error": error,
  };
}

class ServicesModel {
  final String? id;
  final String? providerId;
  final String? title; // Mahalliylashtirilgan sarlavha
  final String? titleUz;
  final String? titleRu;
  final String? titleEn;
  final String? description;
  final String? descriptionUz;
  final String? basePrice;
  final String? maxPrice;
  final String? status;
  final String? primaryImageUrl;
  final String? categoryName; // Mahalliylashtirilgan kategoriya nomi
  final String? categoryNameUz;
  final String? currencyCode;
  final String? currencySymbol;
  final String? provinceName;

  ServicesModel({
    this.id,
    this.providerId,
    this.title,
    this.titleUz,
    this.titleRu,
    this.titleEn,
    this.description,
    this.descriptionUz,
    this.basePrice,
    this.maxPrice,
    this.status,
    this.primaryImageUrl,
    this.categoryName,
    this.categoryNameUz,
    this.currencyCode,
    this.currencySymbol,
    this.provinceName,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    id: json["id"],
    providerId: json["provider_id"],
    // Agar backend "title" yuborsa shuni oladi, bo'lmasa "title_uz"ga tushadi
    title: json["title"] ?? json["title_uz"],
    titleUz: json["title_uz"],
    titleRu: json["title_ru"],
    titleEn: json["title_en"],
    description: json["description"] ?? json["description_uz"],
    descriptionUz: json["description_uz"],
    basePrice: json["base_price"],
    maxPrice: json["max_price"],
    status: json["status"],
    primaryImageUrl: json["primary_image_url"],
    // Kategoriya nomi ham xuddi shunday
    categoryName: json["category_name"] ?? json["category_name_uz"],
    categoryNameUz: json["category_name_uz"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    provinceName: json["province_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "title": title,
    "title_uz": titleUz,
    "title_ru": titleRu,
    "title_en": titleEn,
    "description": description,
    "description_uz": descriptionUz,
    "base_price": basePrice,
    "max_price": maxPrice,
    "status": status,
    "primary_image_url": primaryImageUrl,
    "category_name": categoryName,
    "category_name_uz": categoryNameUz,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "province_name": provinceName,
  };
}
