import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService;

  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  BookingProvider(this._bookingService);

  // Getters
  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get bookings by status
  List<Booking> getBookingsByStatus(BookingStatus status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  Future<void> fetchUserBookings(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final bookings = await _bookingService.getUserBookings(userId);
      _bookings = bookings;
      _error = null;
    } catch (e) {
      _error = 'Failed to fetch bookings: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Booking> createBooking(String userId, String serviceId, DateTime bookingTime) async {
    try {
      final booking = await _bookingService.createBooking(
        userId: userId,
        serviceId: serviceId,
        bookingTime: bookingTime,
      );
      
      _bookings.add(booking);
      notifyListeners();
      return booking;
    } catch (e) {
      _error = 'Failed to create booking: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateBookingStatus(String bookingId, BookingStatus newStatus) async {
    try {
      await _bookingService.updateBookingStatus(bookingId, newStatus);
      
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        // Implementation will be updated when Booking model has a copyWith method
        // _bookings[index] = _bookings[index].copyWith(status: newStatus);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to update booking status: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      await _bookingService.cancelBooking(bookingId);
      
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        // Implementation will be updated when Booking model has a copyWith method
        // _bookings[index] = _bookings[index].copyWith(status: BookingStatus.cancelled);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to cancel booking: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<List<DateTime>> getAvailableSlots(String serviceId, DateTime date) async {
    try {
      return await _bookingService.getAvailableSlots(serviceId, date);
    } catch (e) {
      _error = 'Failed to fetch available slots: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  // Admin methods
  Future<void> fetchAllBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final bookings = await _bookingService.getAllBookings();
      _bookings = bookings;
      _error = null;
    } catch (e) {
      _error = 'Failed to fetch all bookings: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
