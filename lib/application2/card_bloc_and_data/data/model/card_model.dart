class CardListResponse {
  final bool? success;
  final List<CardItem>? data;
  final String? message;
  final dynamic error;

  CardListResponse({this.success, this.data, this.message, this.error});

  factory CardListResponse.fromJson(Map<String, dynamic> json) =>
      CardListResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<CardItem>.from(
                json["data"].map((x) => CardItem.fromJson(x)),
              ),
        message: json["message"],
        error: json["error"],
      );
}

class CardItem {
  final String? id;
  final String? cardNumber;
  final String? cardType;
  final String? cardHolder;
  final bool? isDefault;
  final bool? isActive;
  final String? createdAt;

  CardItem({
    this.id,
    this.cardNumber,
    this.cardType,
    this.cardHolder,
    this.isDefault,
    this.isActive,
    this.createdAt,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) => CardItem(
    id: json["id"],
    cardNumber: json["card_number"],
    cardType: json["card_type"],
    cardHolder: json["card_holder"],
    isDefault: json["is_default"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
  );
}

class BindCardResponse {
  final bool? success;
  final BindCardData? data;
  final String? message;
  final dynamic error;

  BindCardResponse({this.success, this.data, this.message, this.error});

  factory BindCardResponse.fromJson(Map<String, dynamic> json) =>
      BindCardResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : BindCardData.fromJson(json["data"]),
        message: json["message"],
        error: json["error"],
      );
}

class BindCardData {
  final int? transactionId;
  final String? phone;
  final String? message;

  BindCardData({this.transactionId, this.phone, this.message});

  factory BindCardData.fromJson(Map<String, dynamic> json) => BindCardData(
    transactionId: json["transaction_id"],
    phone: json["phone"],
    message: json["message"],
  );
}

class ConfirmCardResponse {
  final bool? success;
  final CardItem? data;
  final String? message;
  final dynamic error;

  ConfirmCardResponse({this.success, this.data, this.message, this.error});

  factory ConfirmCardResponse.fromJson(Map<String, dynamic> json) =>
      ConfirmCardResponse(
        success: json["success"],
        data: json["data"] == null ? null : CardItem.fromJson(json["data"]),
        message: json["message"],
        error: json["error"],
      );
}

class DeleteCardResponse {
  final bool? success;
  final String? message;
  final dynamic error;

  DeleteCardResponse({this.success, this.message, this.error});

  factory DeleteCardResponse.fromJson(Map<String, dynamic> json) =>
      DeleteCardResponse(
        success: json["success"],
        message: json["message"],
        error: json["error"],
      );
}
