enum PaymentStatus { pending, completed, failed }

class Payment {
  final String id;
  final String bookingId;
  final double amount;
  final String method;
  final PaymentStatus status;
  final DateTime transactionDate;

  Payment({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.method,
    required this.status,
    required this.transactionDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      status: _statusFromString(json['status'] as String),
      transactionDate: DateTime.parse(json['transactionDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'amount': amount,
      'method': method,
      'status': status.toString().split('.').last,
      'transactionDate': transactionDate.toIso8601String(),
    };
  }

  static PaymentStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'completed':
        return PaymentStatus.completed;
      case 'failed':
        return PaymentStatus.failed;
      default:
        return PaymentStatus.pending;
    }
  }

  @override
  String toString() {
    return 'Payment{id: $id, bookingId: $bookingId, amount: $amount, status: $status}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Payment &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
