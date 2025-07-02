enum BookingStatus { pending, confirmed, completed, cancelled }

class Booking {
  final String id;
  final String userId;
  final String serviceId;
  final DateTime bookingTime;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.bookingTime,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceId: json['serviceId'] as String,
      bookingTime: DateTime.parse(json['bookingTime'] as String),
      status: _statusFromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'bookingTime': bookingTime.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }

  static BookingStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }

  @override
  String toString() {
    return 'Booking{id: $id, userId: $userId, serviceId: $serviceId, status: $status}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
