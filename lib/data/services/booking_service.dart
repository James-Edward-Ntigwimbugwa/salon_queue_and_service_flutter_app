import 'package:dio/dio.dart';
import '../models/booking.dart';
import '../../core/constants.dart';

class BookingService {
  final Dio _dio;

  BookingService(this._dio);

  Future<List<Booking>> getUserBookings(String userId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.bookings}/user/$userId',
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch user bookings');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<List<Booking>> getAllBookings() async {
    try {
      final response = await _dio.get(ApiConstants.bookings);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch all bookings');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Booking> createBooking({
    required String userId,
    required String serviceId,
    required DateTime bookingTime,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.bookings,
        data: {
          'userId': userId,
          'serviceId': serviceId,
          'bookingTime': bookingTime.toIso8601String(),
          'status': BookingStatus.pending.toString().split('.').last,
        },
      );

      if (response.statusCode == 201) {
        return Booking.fromJson(response.data);
      } else {
        throw Exception('Failed to create booking');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> updateBookingStatus(String bookingId, BookingStatus newStatus) async {
    try {
      final response = await _dio.patch(
        '${ApiConstants.bookings}/$bookingId/status',
        data: {
          'status': newStatus.toString().split('.').last,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update booking status');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      final response = await _dio.patch(
        '${ApiConstants.bookings}/$bookingId/cancel',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel booking');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<List<DateTime>> getAvailableSlots(String serviceId, DateTime date) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.bookings}/available-slots',
        queryParameters: {
          'serviceId': serviceId,
          'date': date.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((slot) => DateTime.parse(slot as String)).toList();
      } else {
        throw Exception('Failed to fetch available slots');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
