part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreatePaymentEvent extends PaymentEvent {
  final String bookingId;
  final String paymentProvider;

  const CreatePaymentEvent({
    required this.bookingId,
    required this.paymentProvider,
  });

  @override
  List<Object?> get props => [bookingId, paymentProvider];
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
