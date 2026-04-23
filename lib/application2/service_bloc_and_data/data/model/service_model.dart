class ServicesData {
  final bool? success;
  final List<ServicesModel>? servicesModel;
  final String? message;
  final dynamic error;

  ServicesData({this.success, this.servicesModel, this.message, this.error});

  factory ServicesData.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"];
    List<ServicesModel> items = [];

    if (rawData is List) {
      items = rawData
          .map((x) => ServicesModel.fromJson(x as Map<String, dynamic>))
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      final rawItems = rawData["items"];
      if (rawItems is List) {
        items = rawItems
            .map((x) => ServicesModel.fromJson(x as Map<String, dynamic>))
            .toList();
      }
    }

    return ServicesData(
      success: json["success"],
      servicesModel: items,
      message: json["message"],
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": servicesModel == null
        ? []
        : List<dynamic>.from(servicesModel!.map((x) => x.toJson())),
    "message": message,
    "error": error,
  };
}

bool? _parseBool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is int) return v != 0;
  if (v is String) {
    final s = v.toLowerCase().trim();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
  }
  return null;
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
  final String? providerName;
  final bool? isFavorite;

  ServicesModel({
    this.providerName,
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
    this.isFavorite,
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
    providerName: json["provider_name"],
    isFavorite: _parseBool(json["is_favorite"]),
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
    "provider_name": providerName,
    "is_favorite": isFavorite,
  };

  ServicesModel copyWith({
    String? id,
    String? providerId,
    String? title,
    String? titleUz,
    String? titleRu,
    String? titleEn,
    String? description,
    String? descriptionUz,
    String? basePrice,
    String? maxPrice,
    String? status,
    String? primaryImageUrl,
    String? categoryName,
    String? categoryNameUz,
    String? currencyCode,
    String? currencySymbol,
    String? provinceName,
    String? providerName,
    bool? isFavorite,
  }) {
    return ServicesModel(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      title: title ?? this.title,
      titleUz: titleUz ?? this.titleUz,
      titleRu: titleRu ?? this.titleRu,
      titleEn: titleEn ?? this.titleEn,
      description: description ?? this.description,
      descriptionUz: descriptionUz ?? this.descriptionUz,
      basePrice: basePrice ?? this.basePrice,
      maxPrice: maxPrice ?? this.maxPrice,
      status: status ?? this.status,
      primaryImageUrl: primaryImageUrl ?? this.primaryImageUrl,
      categoryName: categoryName ?? this.categoryName,
      categoryNameUz: categoryNameUz ?? this.categoryNameUz,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      provinceName: provinceName ?? this.provinceName,
      providerName: providerName ?? this.providerName,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
