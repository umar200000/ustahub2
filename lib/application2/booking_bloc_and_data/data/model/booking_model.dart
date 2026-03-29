class BookingModel {
  final bool? success;
  final BookingData? data;
  final String? message;
  final dynamic error;

  BookingModel({this.success, this.data, this.message, this.error});

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    success: json["success"],
    data: json["data"] == null ? null : BookingData.fromJson(json["data"]),
    message: json["message"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "error": error,
  };

  BookingModel copyWith({
    bool? success,
    BookingData? data,
    String? message,
    dynamic error,
  }) {
    return BookingModel(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

class BookingData {
  final String? id;
  final int? bookingNumber;
  final String? userId;
  final String? providerId;
  final String? serviceId;
  final dynamic masterId;
  final String? serviceTitle;
  final String? providerName;
  final String? providerLogo;
  final double? latitude;
  final double? longitude;
  final String? scheduledDate;
  final String? scheduledTimeStart;
  final dynamic scheduledTimeEnd;
  final bool? isInstantBooking;
  final double? basePrice;
  final double? totalPrice;
  final dynamic finalPrice;
  final String? status;
  final dynamic statusChangedAt;
  final String? regionId;
  final String? userComment;
  final dynamic providerNote;
  final dynamic cancellationReason;
  final dynamic canceledBy;
  final dynamic assignedAt;
  final dynamic acceptedAt;
  final dynamic startedAt;
  final dynamic completedAt;
  final dynamic canceledAt;
  final String? createdAt;
  final String? updatedAt;
  final Review? review;
  final String? address;
  final String? contactPhone;

  BookingData({
    this.id,
    this.bookingNumber,
    this.userId,
    this.providerId,
    this.serviceId,
    this.masterId,
    this.serviceTitle,
    this.providerName,
    this.providerLogo,
    this.latitude,
    this.longitude,
    this.scheduledDate,
    this.scheduledTimeStart,
    this.scheduledTimeEnd,
    this.isInstantBooking,
    this.basePrice,
    this.totalPrice,
    this.finalPrice,
    this.status,
    this.statusChangedAt,
    this.regionId,
    this.userComment,
    this.providerNote,
    this.cancellationReason,
    this.canceledBy,
    this.assignedAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.canceledAt,
    this.createdAt,
    this.updatedAt,
    this.review,
    this.address,
    this.contactPhone,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    id: json["id"],
    bookingNumber: json["booking_number"],
    userId: json["user_id"],
    providerId: json["provider_id"],
    serviceId: json["service_id"],
    masterId: json["master_id"],
    serviceTitle: json["service_title"],
    providerName: json["provider_name"],
    providerLogo: json["provider_logo"],
    latitude: _toDouble(json["latitude"]),
    longitude: _toDouble(json["longitude"]),
    scheduledDate: json["scheduled_date"],
    scheduledTimeStart: json["scheduled_time_start"],
    scheduledTimeEnd: json["scheduled_time_end"],
    isInstantBooking: json["is_instant_booking"],
    basePrice: _toDouble(json["base_price"]),
    totalPrice: _toDouble(json["total_price"]),
    finalPrice: json["final_price"],
    status: json["status"],
    statusChangedAt: json["status_changed_at"],
    regionId: json["region_id"],
    userComment: json["user_comment"],
    providerNote: json["provider_note"],
    cancellationReason: json["cancellation_reason"],
    canceledBy: json["canceled_by"],
    assignedAt: json["assigned_at"],
    acceptedAt: json["accepted_at"],
    startedAt: json["started_at"],
    completedAt: json["completed_at"],
    canceledAt: json["canceled_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    review: json["review"] == null ? null : Review.fromJson(json["review"]),
    address: json["address"],
    contactPhone: json["contact_phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_number": bookingNumber,
    "user_id": userId,
    "provider_id": providerId,
    "service_id": serviceId,
    "master_id": masterId,
    "service_title": serviceTitle,
    "provider_name": providerName,
    "provider_logo": providerLogo,
    "latitude": latitude,
    "longitude": longitude,
    "scheduled_date": scheduledDate,
    "scheduled_time_start": scheduledTimeStart,
    "scheduled_time_end": scheduledTimeEnd,
    "is_instant_booking": isInstantBooking,
    "base_price": basePrice,
    "total_price": totalPrice,
    "final_price": finalPrice,
    "status": status,
    "status_changed_at": statusChangedAt,
    "region_id": regionId,
    "user_comment": userComment,
    "provider_note": providerNote,
    "cancellation_reason": cancellationReason,
    "canceled_by": canceledBy,
    "assigned_at": assignedAt,
    "accepted_at": acceptedAt,
    "started_at": startedAt,
    "completed_at": completedAt,
    "canceled_at": canceledAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "review": review?.toJson(),
    "address": address,
    "contact_phone": contactPhone,
  };

  BookingData copyWith({
    String? id,
    int? bookingNumber,
    String? userId,
    String? providerId,
    String? serviceId,
    dynamic masterId,
    String? serviceTitle,
    String? providerName,
    String? providerLogo,
    double? latitude,
    double? longitude,
    String? scheduledDate,
    String? scheduledTimeStart,
    dynamic scheduledTimeEnd,
    bool? isInstantBooking,
    double? basePrice,
    double? totalPrice,
    dynamic finalPrice,
    String? status,
    dynamic statusChangedAt,
    String? regionId,
    String? userComment,
    dynamic providerNote,
    dynamic cancellationReason,
    dynamic canceledBy,
    dynamic assignedAt,
    dynamic acceptedAt,
    dynamic startedAt,
    dynamic completedAt,
    dynamic canceledAt,
    String? createdAt,
    String? updatedAt,
    Review? review,
    String? address,
    String? contactPhone,
  }) {
    return BookingData(
      id: id ?? this.id,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      userId: userId ?? this.userId,
      providerId: providerId ?? this.providerId,
      serviceId: serviceId ?? this.serviceId,
      masterId: masterId ?? this.masterId,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      providerName: providerName ?? this.providerName,
      providerLogo: providerLogo ?? this.providerLogo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTimeStart: scheduledTimeStart ?? this.scheduledTimeStart,
      scheduledTimeEnd: scheduledTimeEnd ?? this.scheduledTimeEnd,
      isInstantBooking: isInstantBooking ?? this.isInstantBooking,
      basePrice: basePrice ?? this.basePrice,
      totalPrice: totalPrice ?? this.totalPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      status: status ?? this.status,
      statusChangedAt: statusChangedAt ?? this.statusChangedAt,
      regionId: regionId ?? this.regionId,
      userComment: userComment ?? this.userComment,
      providerNote: providerNote ?? this.providerNote,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      canceledBy: canceledBy ?? this.canceledBy,
      assignedAt: assignedAt ?? this.assignedAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      canceledAt: canceledAt ?? this.canceledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      review: review ?? this.review,
      address: address ?? this.address,
      contactPhone: contactPhone ?? this.contactPhone,
    );
  }
}

class Review {
  final int? rating;
  final String? comment;
  final String? createdAt;

  Review({this.rating, this.comment, this.createdAt});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    rating: json["rating"],
    comment: json["comment"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "created_at": createdAt,
  };
}
