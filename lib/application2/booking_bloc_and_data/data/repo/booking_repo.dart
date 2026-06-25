import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';

class BookingRepo {
  final _dio = sl<Dio>();

  /// Uploads a single review image via multipart/form-data.
  /// Returns the uploaded media's ID on success, or null on any failure
  /// (the caller simply skips failed uploads instead of blocking the review).
  Future<String?> uploadReviewImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
        'folder': 'images',
      });
      final response = await _dio.post(
        'api/v1/uploads/images/',
        data: formData,
      );
      if (response.data != null &&
          response.data['success'] == true &&
          response.data['data'] != null) {
        return response.data['data']['id'] as String?;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Response> setReview({
    required String bookingId,
    required int rating,
    required String comment,
    List<String> mediaIds = const [],
  }) async {
    // Build the base payload; only attach media_ids when there are uploads
    // so the request body stays clean for text-only reviews.
    final Map<String, dynamic> data = {
      "booking_id": bookingId,
      "rating": rating,
      "comment": comment,
    };
    if (mediaIds.isNotEmpty) {
      data["media_ids"] = mediaIds;
    }
    final response = await _dio.post(
      "api/v1/client/reviews/",
      data: data,
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

  /// request_based (masofaviy) xizmat uchun — vaqt/joy/to'lov so'ralmaydi.
  /// Bugungi sana va joriy vaqt avtomatik qo'yiladi.
  Future<Response> quickBooking({required String serviceId}) async {
    final now = DateTime.now();
    final date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:00';
    final response = await _dio.post(
      "api/v1/client/bookings/",
      data: {
        "service_id": serviceId,
        "scheduled_date": date,
        "scheduled_time_start": time,
        "payment_method": "cash",
      },
    );
    return response;
  }
}
