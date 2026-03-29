part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

class GetCardsEvent extends CardEvent {
  const GetCardsEvent();
}

class BindCardEvent extends CardEvent {
  final String cardNumber;
  final String expiry;

  const BindCardEvent({required this.cardNumber, required this.expiry});

  @override
  List<Object?> get props => [cardNumber, expiry];
}

class ConfirmCardEvent extends CardEvent {
  final int transactionId;
  final String otp;

  const ConfirmCardEvent({required this.transactionId, required this.otp});

  @override
  List<Object?> get props => [transactionId, otp];
}

class DeleteCardEvent extends CardEvent {
  final String cardId;

  const DeleteCardEvent({required this.cardId});

  @override
  List<Object?> get props => [cardId];
}
