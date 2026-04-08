class BookingModel {
  final bool? success;
  final BookingData? data;
  final String? message;
  final dynamic error;
  final int? total;
  final int? skip;
  final int? limit;

  BookingModel({
    this.success,
    this.data,
    this.message,
    this.error,
    this.total,
    this.skip,
    this.limit,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    success: json["success"],
    data: json["data"] == null ? null : BookingData.fromJson(json["data"]),
    message: json["message"],
    error: json["error"],
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "error": error,
    "total": total,
    "skip": skip,
    "limit": limit,
  };

  BookingModel copyWith({
    bool? success,
    BookingData? data,
    String? message,
    dynamic error,
    int? total,
    int? skip,
    int? limit,
  }) {
    return BookingModel(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
      error: error ?? this.error,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
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
  final String? masterId;
  final BookingUser? user;
  final BookingMaster? master;
  final String? serviceTitle;
  final String? providerName;
  final String? providerLogo;
  final String? contactPhone;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? scheduledDate;
  final String? scheduledTimeStart;
  final dynamic scheduledTimeEnd;
  final bool? isInstantBooking;
  final String? paymentMethod;
  final bool? isPaid;
  final double? basePrice;
  final double? totalPrice;
  final dynamic finalPrice;
  final String? status;
  final dynamic statusChangedAt;
  final String? regionId;
  final Review? review;
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

  BookingData({
    this.id,
    this.bookingNumber,
    this.userId,
    this.providerId,
    this.serviceId,
    this.masterId,
    this.user,
    this.master,
    this.serviceTitle,
    this.providerName,
    this.providerLogo,
    this.contactPhone,
    this.latitude,
    this.longitude,
    this.address,
    this.scheduledDate,
    this.scheduledTimeStart,
    this.scheduledTimeEnd,
    this.isInstantBooking,
    this.paymentMethod,
    this.isPaid,
    this.basePrice,
    this.totalPrice,
    this.finalPrice,
    this.status,
    this.statusChangedAt,
    this.regionId,
    this.review,
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
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    id: json["id"],
    bookingNumber: json["booking_number"],
    userId: json["user_id"],
    providerId: json["provider_id"],
    serviceId: json["service_id"],
    masterId: json["master_id"],
    user: json["user"] == null ? null : BookingUser.fromJson(json["user"]),
    master: json["master"] == null
        ? null
        : BookingMaster.fromJson(json["master"]),
    serviceTitle: json["service_title"],
    providerName: json["provider_name"],
    providerLogo: json["provider_logo"],
    contactPhone: json["contact_phone"],
    latitude: _toDouble(json["latitude"]),
    longitude: _toDouble(json["longitude"]),
    address: json["address"],
    scheduledDate: json["scheduled_date"],
    scheduledTimeStart: json["scheduled_time_start"],
    scheduledTimeEnd: json["scheduled_time_end"],
    isInstantBooking: json["is_instant_booking"],
    paymentMethod: json["payment_method"],
    isPaid: json["is_paid"],
    basePrice: _toDouble(json["base_price"]),
    totalPrice: _toDouble(json["total_price"]),
    finalPrice: json["final_price"],
    status: json["status"],
    statusChangedAt: json["status_changed_at"],
    regionId: json["region_id"],
    review: json["review"] == null ? null : Review.fromJson(json["review"]),
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_number": bookingNumber,
    "user_id": userId,
    "provider_id": providerId,
    "service_id": serviceId,
    "master_id": masterId,
    "user": user?.toJson(),
    "master": master?.toJson(),
    "service_title": serviceTitle,
    "provider_name": providerName,
    "provider_logo": providerLogo,
    "contact_phone": contactPhone,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "scheduled_date": scheduledDate,
    "scheduled_time_start": scheduledTimeStart,
    "scheduled_time_end": scheduledTimeEnd,
    "is_instant_booking": isInstantBooking,
    "payment_method": paymentMethod,
    "is_paid": isPaid,
    "base_price": basePrice,
    "total_price": totalPrice,
    "final_price": finalPrice,
    "status": status,
    "status_changed_at": statusChangedAt,
    "region_id": regionId,
    "review": review?.toJson(),
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
  };

  BookingData copyWith({
    String? id,
    int? bookingNumber,
    String? userId,
    String? providerId,
    String? serviceId,
    String? masterId,
    BookingUser? user,
    BookingMaster? master,
    String? serviceTitle,
    String? providerName,
    String? providerLogo,
    String? contactPhone,
    double? latitude,
    double? longitude,
    String? address,
    String? scheduledDate,
    String? scheduledTimeStart,
    dynamic scheduledTimeEnd,
    bool? isInstantBooking,
    String? paymentMethod,
    bool? isPaid,
    double? basePrice,
    double? totalPrice,
    dynamic finalPrice,
    String? status,
    dynamic statusChangedAt,
    String? regionId,
    Review? review,
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
  }) {
    return BookingData(
      id: id ?? this.id,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      userId: userId ?? this.userId,
      providerId: providerId ?? this.providerId,
      serviceId: serviceId ?? this.serviceId,
      masterId: masterId ?? this.masterId,
      user: user ?? this.user,
      master: master ?? this.master,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      providerName: providerName ?? this.providerName,
      providerLogo: providerLogo ?? this.providerLogo,
      contactPhone: contactPhone ?? this.contactPhone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTimeStart: scheduledTimeStart ?? this.scheduledTimeStart,
      scheduledTimeEnd: scheduledTimeEnd ?? this.scheduledTimeEnd,
      isInstantBooking: isInstantBooking ?? this.isInstantBooking,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      basePrice: basePrice ?? this.basePrice,
      totalPrice: totalPrice ?? this.totalPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      status: status ?? this.status,
      statusChangedAt: statusChangedAt ?? this.statusChangedAt,
      regionId: regionId ?? this.regionId,
      review: review ?? this.review,
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
    );
  }
}

class BookingUser {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatarUrl;

  BookingUser({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatarUrl,
  });

  factory BookingUser.fromJson(Map<String, dynamic> json) => BookingUser(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "avatar_url": avatarUrl,
  };
}

class BookingMaster {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatarUrl;
  final double? averageRating;
  final int? yearsOfExperience;

  BookingMaster({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatarUrl,
    this.averageRating,
    this.yearsOfExperience,
  });

  factory BookingMaster.fromJson(Map<String, dynamic> json) => BookingMaster(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    avatarUrl: json["avatar_url"],
    averageRating: _toDouble(json["average_rating"]),
    yearsOfExperience: json["years_of_experience"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "avatar_url": avatarUrl,
    "average_rating": averageRating,
    "years_of_experience": yearsOfExperience,
  };
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
