import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class PaymentRepo {
  final _dio = sl<Dio>();

  Future<Response> createPayment({
    required String bookingId,
    required String paymentProvider,
    String? cardId,
  }) async {
    return await _dio.post(
      "api/v1/client/payments/",
      data: {
        "booking_id": bookingId,
        "payment_provider": paymentProvider,
        if (cardId != null && cardId.isNotEmpty) "card_id": cardId,
      },
    );
  }

  Future<Response> getPaymentHistory() async {
    return await _dio.get("api/v1/client/payments/my/");
  }

  Future<Response> getPaymentDetail({required String paymentId}) async {
    return await _dio.get("api/v1/client/payments/$paymentId/");
  }

  Future<Response> preApplyPayment({
    required String paymentId,
    required String cardId,
  }) async {
    return await _dio.post(
      "api/v1/client/payments/$paymentId/atmos/pre-apply/",
      data: {"card_id": cardId},
    );
  }

  Future<Response> applyPayment({required String paymentId}) async {
    return await _dio.post(
      "api/v1/client/payments/$paymentId/atmos/apply/",
    );
  }
}
