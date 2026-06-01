import 'package:equatable/equatable.dart';

// GET /api/v1/client/provinces/?region_id=...
// {id, code, name_uz, name_ru, name_en, region_id, is_active}
class ExpressProvinceModel extends Equatable {
  final String? id;
  final String? code;
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final String? regionId;
  final bool? isActive;

  const ExpressProvinceModel({
    this.id,
    this.code,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.regionId,
    this.isActive,
  });

  factory ExpressProvinceModel.fromJson(Map<String, dynamic> json) {
    return ExpressProvinceModel(
      id: json['id']?.toString(),
      code: json['code']?.toString(),
      nameUz: json['name_uz'] ?? json['nameUz'] ?? json['name'],
      nameRu: json['name_ru'] ?? json['nameRu'],
      nameEn: json['name_en'] ?? json['nameEn'],
      regionId: json['region_id']?.toString(),
      isActive: json['is_active'] is bool ? json['is_active'] : null,
    );
  }

  String name(String langCode) {
    switch (langCode) {
      case 'ru':
        return nameRu ?? nameUz ?? nameEn ?? '';
      case 'en':
        return nameEn ?? nameUz ?? nameRu ?? '';
      default:
        return nameUz ?? nameRu ?? nameEn ?? '';
    }
  }

  @override
  List<Object?> get props =>
      [id, code, nameUz, nameRu, nameEn, regionId, isActive];
}

// GET /api/v1/client/districts/?province_id=...
// {id, code, name_uz, name_ru, name_en, province_id, is_active}
class ExpressDistrictModel extends Equatable {
  final String? id;
  final String? code;
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final String? provinceId;
  final bool? isActive;

  const ExpressDistrictModel({
    this.id,
    this.code,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.provinceId,
    this.isActive,
  });

  factory ExpressDistrictModel.fromJson(Map<String, dynamic> json) {
    return ExpressDistrictModel(
      id: json['id']?.toString(),
      code: json['code']?.toString(),
      nameUz: json['name_uz'] ?? json['nameUz'] ?? json['name'],
      nameRu: json['name_ru'] ?? json['nameRu'],
      nameEn: json['name_en'] ?? json['nameEn'],
      provinceId: json['province_id']?.toString(),
      isActive: json['is_active'] is bool ? json['is_active'] : null,
    );
  }

  String name(String langCode) {
    switch (langCode) {
      case 'ru':
        return nameRu ?? nameUz ?? nameEn ?? '';
      case 'en':
        return nameEn ?? nameUz ?? nameRu ?? '';
      default:
        return nameUz ?? nameRu ?? nameEn ?? '';
    }
  }

  @override
  List<Object?> get props =>
      [id, code, nameUz, nameRu, nameEn, provinceId, isActive];
}

// GET /api/v1/client/express/categories/?province_id=...
// {id, name_uz, name_ru, name_en, icon_url, express_service_count, base_price, max_price, category_type}
class ExpressCategoryModel extends Equatable {
  final String? id;
  final String? nameUz;
  final String? nameRu;
  final String? nameEn;
  final String? iconUrl;
  final int? expressServiceCount;
  final num? basePrice;
  final num? maxPrice;
  /// 'on_site' | 'request_based'
  final String? categoryType;

  const ExpressCategoryModel({
    this.id,
    this.nameUz,
    this.nameRu,
    this.nameEn,
    this.iconUrl,
    this.expressServiceCount,
    this.basePrice,
    this.maxPrice,
    this.categoryType,
  });

  /// Masofaviy xizmat — usta mijoz manziliga bormaydi
  bool get isRemote => categoryType == 'request_based';

  factory ExpressCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpressCategoryModel(
      id: json['id']?.toString(),
      nameUz: json['name_uz'] ?? json['nameUz'] ?? json['name'],
      nameRu: json['name_ru'] ?? json['nameRu'],
      nameEn: json['name_en'] ?? json['nameEn'],
      iconUrl: json['icon_url']?.toString() ?? json['iconUrl']?.toString(),
      expressServiceCount: json['express_service_count'] is num
          ? (json['express_service_count'] as num).toInt()
          : null,
      basePrice: json['base_price'] is num
          ? json['base_price'] as num
          : num.tryParse(json['base_price']?.toString() ?? ''),
      maxPrice: json['max_price'] is num
          ? json['max_price'] as num
          : num.tryParse(json['max_price']?.toString() ?? ''),
      categoryType: json['category_type']?.toString(),
    );
  }

  String name(String langCode) {
    switch (langCode) {
      case 'ru':
        return nameRu ?? nameUz ?? nameEn ?? '';
      case 'en':
        return nameEn ?? nameUz ?? nameRu ?? '';
      default:
        return nameUz ?? nameRu ?? nameEn ?? '';
    }
  }

  @override
  List<Object?> get props =>
      [id, nameUz, nameRu, nameEn, iconUrl, expressServiceCount, basePrice, maxPrice, categoryType];
}

// POST /api/v1/client/express/search/  → javob
class ExpressSessionModel extends Equatable {
  final String? sessionId;
  final String? status;
  final int? totalMasters;
  final String? message;
  final num? basePrice;
  final num? maxPrice;

  const ExpressSessionModel({
    this.sessionId,
    this.status,
    this.totalMasters,
    this.message,
    this.basePrice,
    this.maxPrice,
  });

  factory ExpressSessionModel.fromJson(Map<String, dynamic> json) {
    return ExpressSessionModel(
      sessionId: json['session_id']?.toString(),
      status: json['status'],
      totalMasters: json['total_masters'] is num
          ? (json['total_masters'] as num).toInt()
          : null,
      message: json['message'],
      basePrice: json['base_price'] is num
          ? json['base_price'] as num
          : num.tryParse(json['base_price']?.toString() ?? ''),
      maxPrice: json['max_price'] is num
          ? json['max_price'] as num
          : num.tryParse(json['max_price']?.toString() ?? ''),
    );
  }

  bool get isExhausted => status == 'exhausted';

  @override
  List<Object?> get props => [sessionId, status, totalMasters, message, basePrice, maxPrice];
}

// WS: express_matched
class ExpressMatchedModel extends Equatable {
  final String? sessionId;
  final String? bookingId;
  final String? masterId;
  final String? masterName;
  final String? masterPhone;

  const ExpressMatchedModel({
    this.sessionId,
    this.bookingId,
    this.masterId,
    this.masterName,
    this.masterPhone,
  });

  factory ExpressMatchedModel.fromJson(Map<String, dynamic> json) {
    return ExpressMatchedModel(
      sessionId: json['session_id']?.toString(),
      bookingId: json['booking_id']?.toString(),
      masterId: json['master_id']?.toString(),
      masterName: json['master_name'],
      masterPhone: json['master_phone'],
    );
  }

  @override
  List<Object?> get props =>
      [sessionId, bookingId, masterId, masterName, masterPhone];
}

// GET /api/v1/client/express/search/{id}/status/
class ExpressStatusModel extends Equatable {
  final String? sessionId;
  final String? status;
  final String? bookingId;
  final String? masterName;
  final String? masterPhone;

  const ExpressStatusModel({
    this.sessionId,
    this.status,
    this.bookingId,
    this.masterName,
    this.masterPhone,
  });

  factory ExpressStatusModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    // Backend returns nested master_info when status == 'matched'
    final masterInfoRaw = data['master_info'];
    final masterInfo = masterInfoRaw is Map
        ? Map<String, dynamic>.from(masterInfoRaw as Map)
        : null;
    final firstName = masterInfo?['first_name']?.toString() ?? '';
    final lastName = masterInfo?['last_name']?.toString() ?? '';
    final masterNameStr = '$firstName $lastName'.trim();
    return ExpressStatusModel(
      sessionId: data['session_id']?.toString(),
      status: data['status']?.toString(),
      bookingId: data['booking_id']?.toString(),
      masterName: masterNameStr.isEmpty ? null : masterNameStr,
      masterPhone: masterInfo?['phone']?.toString(),
    );
  }

  @override
  List<Object?> get props =>
      [sessionId, status, bookingId, masterName, masterPhone];
}
