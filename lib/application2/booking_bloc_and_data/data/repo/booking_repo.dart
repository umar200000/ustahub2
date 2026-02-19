import 'package:dio/dio.dart';

import '../../../../infrastructure2/init/injection.dart';
import '../mock/booking_mock_data.dart';

class BookingRepo {
  final _dio = sl<Dio>();

  Future<Response> getBookingDetails({required String id}) async {
    // Use mock data
    if (BookingMockData.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: BookingMockData.getMockBookingDetails(id),
      );
    }

    final response = await _dio.get("api/v1/client/bookings/my/$id/");
    return response;
  }

  Future<Response> getBookingsList({int limit = 20, int skip = 0}) async {
    // Use mock data
    if (BookingMockData.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      final mockData = BookingMockData.getMockBookingsList();

      // Simulate pagination
      final allItems = mockData['data'] as List;
      final paginatedItems = allItems.skip(skip).take(limit).toList();

      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          ...mockData,
          'data': paginatedItems,
        },
      );
    }

    final response = await _dio.get(
      "api/v1/client/bookings/my/",
      queryParameters: {"limit": limit, "skip": skip},
    );
    return response;
  }

  Future<Response> bookingService({
    required String serviceId,
    required int latitude,
    required int longitude,
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
        "address": address,
        "user_comment": userComment,
      },
    );
    return response;
  }
}
