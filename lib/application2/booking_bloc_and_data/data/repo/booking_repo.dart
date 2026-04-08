import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class BookingRepo {
  final _dio = sl<Dio>();

  Future<Response> setReview({
    required String bookingId,
    required int rating,
    required String comment,
  }) async {
    final response = await _dio.post(
      "api/v1/client/reviews/",
      data: {"booking_id": bookingId, "rating": rating, "comment": comment},
    );
    return response;
  }

  Future<Response> getBookingDetails({required String id}) async {
    final response = await _dio.get("api/v1/client/bookings/my/$id/");
    return response;
  }

  Future<Response> getBookingsList({int limit = 20, int skip = 0}) async {
    final response = await _dio.get(
      "api/v1/client/bookings/my/",
      queryParameters: {"limit": limit, "skip": skip},
    );
    return response;
  }

  Future<Response> confirmArrival({required String bookingId}) async {
    final response = await _dio.post(
      "api/v1/client/bookings/my/$bookingId/confirm-arrival/",
    );
    return response;
  }

  Future<Response> cancelBooking({
    required String bookingId,
    required String cancellationReason,
  }) async {
    final response = await _dio.post(
      "api/v1/client/bookings/my/$bookingId/cancel/",
      data: {"cancellation_reason": cancellationReason},
    );
    return response;
  }

  Future<Response> bookingService({
    required String serviceId,
    required double latitude,
    required double longitude,
    required String scheduledDate,
    required String scheduledTimeStart,
    required String address,
    required String userComment,
  }) async {
    final response = await _dio.post(
      "api/v1/client/bookings/",
      data: {
        "service_id": serviceId,
        "latitude": latitude,
        "longitude": longitude,
        "scheduled_date": scheduledDate,
        "scheduled_time_start": scheduledTimeStart,
        "user_comment": userComment,
      },
    );
    return response;
  }
}
