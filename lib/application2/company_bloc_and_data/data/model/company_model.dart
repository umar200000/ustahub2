class CompanyResponse {
  final bool? success;
  final CompanyData? data;
  final String? message;
  final dynamic error;

  CompanyResponse({this.success, this.data, this.message, this.error});

  factory CompanyResponse.fromJson(Map<String, dynamic> json) =>
      CompanyResponse(
        success: json["success"],
        data: json["data"] == null ? null : CompanyData.fromJson(json["data"]),
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "error": error,
  };
}

class CompanyData {
  final List<CompanyItem>? items;
  final int? total;
  final int? skip;
  final int? limit;
  final bool? hasMore;

  CompanyData({this.items, this.total, this.skip, this.limit, this.hasMore});

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
    items: json["items"] == null
        ? []
        : List<CompanyItem>.from(
            json["items"]!.map((x) => CompanyItem.fromJson(x)),
          ),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
    hasMore: json["has_more"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
    "has_more": hasMore,
  };
}

class CompanyItem {
  final String? id;
  final String? name;
  final String? logoUrl;
  final String? description;
  final dynamic rating;

  CompanyItem({
    this.id,
    this.name,
    this.logoUrl,
    this.description,
    this.rating,
  });

  factory CompanyItem.fromJson(Map<String, dynamic> json) => CompanyItem(
    id: json["id"],
    name: json["name"],
    logoUrl: json["logo_url"],
    description: json["description"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo_url": logoUrl,
    "description": description,
    "rating": rating,
  };
}
