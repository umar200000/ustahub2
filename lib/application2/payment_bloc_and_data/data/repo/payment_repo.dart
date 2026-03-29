import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class PaymentRepo {
  final _dio = sl<Dio>();

  Future<Response> createPayment({
    required String bookingId,
    required String paymentProvider,
  }) async {
    return await _dio.post(
      "api/v1/client/payments/",
      data: {
        "booking_id": bookingId,
        "payment_provider": paymentProvider,
      },
    );
  }

  Future<Response> getPaymentHistory() async {
    return await _dio.get("api/v1/client/payments/my/");
  }

  Future<Response> getPaymentDetail({required String paymentId}) async {
    return await _dio.get("api/v1/client/payments/$paymentId/");
  }
}
