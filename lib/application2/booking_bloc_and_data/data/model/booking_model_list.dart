class BookingModelList {
  final bool? success;
  final List<BookingListItem>? data;
  final String? message;
  final dynamic error;

  BookingModelList({this.success, this.data, this.message, this.error});

  factory BookingModelList.fromJson(Map<String, dynamic> json) =>
      BookingModelList(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<BookingListItem>.from(
                json["data"].map((x) => BookingListItem.fromJson(x)),
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

class BookingListItem {
  final String? id;
  final int? bookingNumber;
  final String? serviceId;
  final dynamic masterId;
  final String? serviceTitle;
  final String? providerName;
  final String? providerLogo;
  final String? scheduledDate;
  final String? scheduledTimeStart;
  final String? status;
  final double? totalPrice;
  final String? createdAt;

  BookingListItem({
    this.id,
    this.bookingNumber,
    this.serviceId,
    this.masterId,
    this.serviceTitle,
    this.providerName,
    this.providerLogo,
    this.scheduledDate,
    this.scheduledTimeStart,
    this.status,
    this.totalPrice,
    this.createdAt,
  });

  factory BookingListItem.fromJson(Map<String, dynamic> json) =>
      BookingListItem(
        id: json["id"],
        bookingNumber: json["booking_number"],
        serviceId: json["service_id"],
        masterId: json["master_id"],
        serviceTitle: json["service_title"],
        providerName: json["provider_name"],
        providerLogo: json["provider_logo"],
        scheduledDate: json["scheduled_date"],
        scheduledTimeStart: json["scheduled_time_start"],
        status: json["status"],
        totalPrice: json["total_price"]?.toDouble(),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_number": bookingNumber,
    "service_id": serviceId,
    "master_id": masterId,
    "service_title": serviceTitle,
    "provider_name": providerName,
    "provider_logo": providerLogo,
    "scheduled_date": scheduledDate,
    "scheduled_time_start": scheduledTimeStart,
    "status": status,
    "total_price": totalPrice,
    "created_at": createdAt,
  };
}
