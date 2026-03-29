part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final Status2 status;
  final Status2 historyStatus;
  final Status2 detailStatus;
  final PaymentData? paymentData;
  final List<PaymentHistoryItem> historyItems;
  final PaymentDetailData? detailData;
  final String? errorMessage;
  final String? successMessage;

  const PaymentState({
    this.status = Status2.initial,
    this.historyStatus = Status2.initial,
    this.detailStatus = Status2.initial,
    this.paymentData,
    this.historyItems = const [],
    this.detailData,
    this.errorMessage,
    this.successMessage,
  });

  PaymentState copyWith({
    Status2? status,
    Status2? historyStatus,
    Status2? detailStatus,
    PaymentData? paymentData,
    List<PaymentHistoryItem>? historyItems,
    PaymentDetailData? detailData,
    String? errorMessage,
    String? successMessage,
  }) {
    return PaymentState(
      status: status ?? this.status,
      historyStatus: historyStatus ?? this.historyStatus,
      detailStatus: detailStatus ?? this.detailStatus,
      paymentData: paymentData ?? this.paymentData,
      historyItems: historyItems ?? this.historyItems,
      detailData: detailData ?? this.detailData,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    historyStatus,
    detailStatus,
    paymentData,
    historyItems,
    detailData,
    errorMessage,
    successMessage,
  ];
}
