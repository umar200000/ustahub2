part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final Status2 status;
  final Status2 historyStatus;
  final Status2 detailStatus;
  final Status2 preApplyStatus;
  final Status2 applyStatus;
  final Status2 tokenBalanceStatus;
  final Status2 tokenPayStatus;
  final PaymentData? paymentData;
  final List<PaymentHistoryItem> historyItems;
  final PaymentDetailData? detailData;
  final int? tokenBalance;
  final String? errorMessage;
  final String? successMessage;

  const PaymentState({
    this.status = Status2.initial,
    this.historyStatus = Status2.initial,
    this.detailStatus = Status2.initial,
    this.preApplyStatus = Status2.initial,
    this.applyStatus = Status2.initial,
    this.tokenBalanceStatus = Status2.initial,
    this.tokenPayStatus = Status2.initial,
    this.paymentData,
    this.historyItems = const [],
    this.detailData,
    this.tokenBalance,
    this.errorMessage,
    this.successMessage,
  });

  PaymentState copyWith({
    Status2? status,
    Status2? historyStatus,
    Status2? detailStatus,
    Status2? preApplyStatus,
    Status2? applyStatus,
    Status2? tokenBalanceStatus,
    Status2? tokenPayStatus,
    PaymentData? paymentData,
    List<PaymentHistoryItem>? historyItems,
    PaymentDetailData? detailData,
    int? tokenBalance,
    String? errorMessage,
    String? successMessage,
  }) {
    return PaymentState(
      status: status ?? this.status,
      historyStatus: historyStatus ?? this.historyStatus,
      detailStatus: detailStatus ?? this.detailStatus,
      preApplyStatus: preApplyStatus ?? this.preApplyStatus,
      applyStatus: applyStatus ?? this.applyStatus,
      tokenBalanceStatus: tokenBalanceStatus ?? this.tokenBalanceStatus,
      tokenPayStatus: tokenPayStatus ?? this.tokenPayStatus,
      paymentData: paymentData ?? this.paymentData,
      historyItems: historyItems ?? this.historyItems,
      detailData: detailData ?? this.detailData,
      tokenBalance: tokenBalance ?? this.tokenBalance,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    historyStatus,
    detailStatus,
    preApplyStatus,
    applyStatus,
    tokenBalanceStatus,
    tokenPayStatus,
    paymentData,
    historyItems,
    detailData,
    tokenBalance,
    errorMessage,
    successMessage,
  ];
}
