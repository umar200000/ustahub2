part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreatePaymentEvent extends PaymentEvent {
  final String bookingId;
  final String paymentProvider;
  final String? cardId;

  const CreatePaymentEvent({
    required this.bookingId,
    required this.paymentProvider,
    this.cardId,
  });

  @override
  List<Object?> get props => [bookingId, paymentProvider, cardId];
}

class GetPaymentHistoryEvent extends PaymentEvent {
  const GetPaymentHistoryEvent();
}

class GetPaymentDetailEvent extends PaymentEvent {
  final String paymentId;

  const GetPaymentDetailEvent({required this.paymentId});

  @override
  List<Object?> get props => [paymentId];
}

class PreApplyPaymentEvent extends PaymentEvent {
  final String paymentId;
  final String cardId;

  const PreApplyPaymentEvent({
    required this.paymentId,
    required this.cardId,
  });

  @override
  List<Object?> get props => [paymentId, cardId];
}

class ApplyPaymentEvent extends PaymentEvent {
  final String paymentId;

  const ApplyPaymentEvent({required this.paymentId});

  @override
  List<Object?> get props => [paymentId];
}

class ResetPaymentFlowEvent extends PaymentEvent {
  const ResetPaymentFlowEvent();
}
