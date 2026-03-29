part of 'card_bloc.dart';

class CardState extends Equatable {
  final Status2 listStatus;
  final Status2 bindStatus;
  final Status2 confirmStatus;
  final Status2 deleteStatus;
  final List<CardItem> cards;
  final int? transactionId;
  final String? phone;
  final String? errorMessage;
  final String? successMessage;

  const CardState({
    this.listStatus = Status2.initial,
    this.bindStatus = Status2.initial,
    this.confirmStatus = Status2.initial,
    this.deleteStatus = Status2.initial,
    this.cards = const [],
    this.transactionId,
    this.phone,
    this.errorMessage,
    this.successMessage,
  });

  CardState copyWith({
    Status2? listStatus,
    Status2? bindStatus,
    Status2? confirmStatus,
    Status2? deleteStatus,
    List<CardItem>? cards,
    int? transactionId,
    String? phone,
    String? errorMessage,
    String? successMessage,
  }) {
    return CardState(
      listStatus: listStatus ?? this.listStatus,
      bindStatus: bindStatus ?? this.bindStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      cards: cards ?? this.cards,
      transactionId: transactionId ?? this.transactionId,
      phone: phone ?? this.phone,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    listStatus,
    bindStatus,
    confirmStatus,
    deleteStatus,
    cards,
    transactionId,
    phone,
    errorMessage,
    successMessage,
  ];
}
