class SearchListResponse {
  final bool? success;
  final List<SearchListItem>? data;
  final String? message;
  final dynamic error;

  SearchListResponse({this.success, this.data, this.message, this.error});

  factory SearchListResponse.fromJson(Map<String, dynamic> json) =>
      SearchListResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<SearchListItem>.from(
                json["data"].map((x) => SearchListItem.fromJson(x)),
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

class SearchListItem {
  final String? id;
  final String? providerId;
  final String? titleUz;
  final String? titleRu;
  final String? titleEn;
  final String? descriptionUz;
  final String? basePrice;
  final String? maxPrice;
  final String? status;
  final String? primaryImageUrl;
  final String? categoryNameUz;
  final String? currencyCode;
  final String? currencySymbol;

  SearchListItem({
    this.id,
    this.providerId,
    this.titleUz,
    this.titleRu,
    this.titleEn,
    this.descriptionUz,
    this.basePrice,
    this.maxPrice,
    this.status,
    this.primaryImageUrl,
    this.categoryNameUz,
    this.currencyCode,
    this.currencySymbol,
  });

  factory SearchListItem.fromJson(Map<String, dynamic> json) => SearchListItem(
    id: json["id"],
    providerId: json["provider_id"],
    titleUz: json["title_uz"],
    titleRu: json["title_ru"],
    titleEn: json["title_en"],
    descriptionUz: json["description_uz"],
    basePrice: json["base_price"],
    maxPrice: json["max_price"],
    status: json["status"],
    primaryImageUrl: json["primary_image_url"],
    categoryNameUz: json["category_name_uz"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_id": providerId,
    "title_uz": titleUz,
    "title_ru": titleRu,
    "title_en": titleEn,
    "description_uz": descriptionUz,
    "base_price": basePrice,
    "max_price": maxPrice,
    "status": status,
    "primary_image_url": primaryImageUrl,
    "category_name_uz": categoryNameUz,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
  };
}
