class PaymentResponse {
  final bool? success;
  final PaymentData? data;
  final String? message;
  final dynamic error;

  PaymentResponse({this.success, this.data, this.message, this.error});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PaymentData.fromJson(json["data"]),
        message: json["message"],
        error: json["error"],
      );
}

class PaymentData {
  final String? id;
  final String? bookingId;
  final int? amount;
  final String? currency;
  final String? paymentProvider;
  final String? status;
  final String? paymentUrl;

  PaymentData({
    this.id,
    this.bookingId,
    this.amount,
    this.currency,
    this.paymentProvider,
    this.status,
    this.paymentUrl,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    bookingId: json["booking_id"],
    amount: json["amount"] is int
        ? json["amount"]
        : int.tryParse(json["amount"]?.toString().split('.').first ?? ""),
    currency: json["currency"],
    paymentProvider: json["payment_provider"],
    status: json["status"],
    paymentUrl: json["payment_url"],
  );
}

class PaymentHistoryResponse {
  final bool? success;
  final List<PaymentHistoryItem>? data;
  final String? message;
  final dynamic error;

  PaymentHistoryResponse({this.success, this.data, this.message, this.error});

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<PaymentHistoryItem>.from(
                json["data"].map((x) => PaymentHistoryItem.fromJson(x)),
              ),
        message: json["message"],
        error: json["error"],
      );
}

class PaymentHistoryItem {
  final String? id;
  final String? transactionId;
  final String? paymentType;
  final String? paymentProvider;
  final String? amount;
  final String? currency;
  final String? status;
  final String? createdAt;

  PaymentHistoryItem({
    this.id,
    this.transactionId,
    this.paymentType,
    this.paymentProvider,
    this.amount,
    this.currency,
    this.status,
    this.createdAt,
  });

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryItem(
        id: json["id"],
        transactionId: json["transaction_id"],
        paymentType: json["payment_type"],
        paymentProvider: json["payment_provider"],
        amount: json["amount"]?.toString(),
        currency: json["currency"],
        status: json["status"],
        createdAt: json["created_at"],
      );
}

class PaymentDetailResponse {
  final bool? success;
  final PaymentDetailData? data;
  final String? message;
  final dynamic error;

  PaymentDetailResponse({this.success, this.data, this.message, this.error});

  factory PaymentDetailResponse.fromJson(Map<String, dynamic> json) =>
      PaymentDetailResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PaymentDetailData.fromJson(json["data"]),
        message: json["message"],
        error: json["error"],
      );
}

class PaymentDetailData {
  final String? id;
  final String? amount;
  final String? currency;
  final String? status;
  final String? paymentType;
  final String? paymentProvider;
  final String? paidAt;

  PaymentDetailData({
    this.id,
    this.amount,
    this.currency,
    this.status,
    this.paymentType,
    this.paymentProvider,
    this.paidAt,
  });

  factory PaymentDetailData.fromJson(Map<String, dynamic> json) =>
      PaymentDetailData(
        id: json["id"],
        amount: json["amount"]?.toString(),
        currency: json["currency"],
        status: json["status"],
        paymentType: json["payment_type"],
        paymentProvider: json["payment_provider"],
        paidAt: json["paid_at"],
      );
}
