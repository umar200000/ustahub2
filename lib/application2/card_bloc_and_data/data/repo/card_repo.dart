import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class CardRepo {
  final _dio = sl<Dio>();

  Future<Response> getCards() async {
    return await _dio.get("api/v1/client/cards/");
  }

  Future<Response> bindCard({
    required String cardNumber,
    required String expiry,
  }) async {
    return await _dio.post(
      "api/v1/client/cards/bind/",
      data: {"card_number": cardNumber, "expiry": expiry},
    );
  }

  Future<Response> confirmCard({
    required int transactionId,
    required String otp,
  }) async {
    return await _dio.post(
      "api/v1/client/cards/confirm/",
      data: {"transaction_id": transactionId, "otp": otp},
    );
  }

  Future<Response> deleteCard({required String cardId}) async {
    return await _dio.delete("api/v1/client/cards/$cardId/");
  }
}
