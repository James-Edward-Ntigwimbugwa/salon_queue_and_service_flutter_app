class FeedbackModel {
  final String id;
  final String bookingId;
  final String userId;
  final int serviceRating;
  final String comments;
  final DateTime timestamp;

  FeedbackModel({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.serviceRating,
    required this.comments,
    required this.timestamp,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      userId: json['userId'] as String,
      serviceRating: json['serviceRating'] as int,
      comments: json['comments'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'userId': userId,
      'serviceRating': serviceRating,
      'comments': comments,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'FeedbackModel{id: $id, bookingId: $bookingId, rating: $serviceRating}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
