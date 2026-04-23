class FavoriteListResponse {
  final bool? success;
  final List<FavoriteServiceData>? data;
  final String? message;
  final dynamic error;
  final int? total;
  final int? skip;
  final int? limit;
  final bool? hasMore;

  FavoriteListResponse({
    this.success,
    this.data,
    this.message,
    this.error,
    this.total,
    this.skip,
    this.limit,
    this.hasMore,
  });

  factory FavoriteListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"];

    List<FavoriteServiceData>? items;
    int? total;
    int? skip;
    int? limit;
    bool? hasMore;

    if (rawData is Map<String, dynamic>) {
      final rawItems = rawData["items"];
      if (rawItems is List) {
        items = rawItems
            .map((x) => FavoriteServiceData.fromJson(x as Map<String, dynamic>))
            .toList();
      }
      total = rawData["total"];
      skip = rawData["skip"];
      limit = rawData["limit"];
      hasMore = rawData["has_more"];
    } else if (rawData is List) {
      // Backwards compatibility — eski tuzilma (data bevosita list)
      items = rawData
          .map((x) => FavoriteServiceData.fromJson(x as Map<String, dynamic>))
          .toList();
      total = json["total"];
      skip = json["skip"];
      limit = json["limit"];
    }

    return FavoriteListResponse(
      success: json["success"],
      data: items,
      message: json["message"],
      error: json["error"],
      total: total,
      skip: skip,
      limit: limit,
      hasMore: hasMore,
    );
  }
}

class FavoriteServiceData {
  final String? id;
  final String? providerId;
  final String? providerName;
  final String? title;
  final String? description;
  final String? basePrice;
  final String? maxPrice;
  final String? status;
  final String? primaryImageUrl;
  final String? categoryName;
  final String? provinceId;
  final String? provinceName;
  final String? currencyCode;
  final String? currencySymbol;
  final bool? isFavorite;
  final String? favoritedAt;

  FavoriteServiceData({
    this.id,
    this.providerId,
    this.providerName,
    this.title,
    this.description,
    this.basePrice,
    this.maxPrice,
    this.status,
    this.primaryImageUrl,
    this.categoryName,
    this.provinceId,
    this.provinceName,
    this.currencyCode,
    this.currencySymbol,
    this.isFavorite = true,
    this.favoritedAt,
  });

  factory FavoriteServiceData.fromJson(Map<String, dynamic> json) =>
      FavoriteServiceData(
        id: json["id"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
        title: json["title"],
        description: json["description"],
        basePrice: json["base_price"]?.toString(),
        maxPrice: json["max_price"]?.toString(),
        status: json["status"],
        primaryImageUrl: json["primary_image_url"],
        categoryName: json["category_name"],
        provinceId: json["province_id"],
        provinceName: json["province_name"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        isFavorite: _parseFavBool(json["is_favorite"]) ?? true,
        favoritedAt: json["favorited_at"],
      );
}

bool? _parseFavBool(dynamic v) {
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
