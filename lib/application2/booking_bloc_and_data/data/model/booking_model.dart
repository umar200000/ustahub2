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
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    scheduledDate: json["scheduled_date"],
    scheduledTimeStart: json["scheduled_time_start"],
    scheduledTimeEnd: json["scheduled_time_end"],
    isInstantBooking: json["is_instant_booking"],
    basePrice: json["base_price"]?.toDouble(),
    totalPrice: json["total_price"]?.toDouble(),
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
  };
}
