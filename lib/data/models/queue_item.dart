class QueueItem {
  final String id;
  final String userId;
  final String serviceId;
  final int currentPosition;
  final Duration estimatedWaitingTime;

  QueueItem({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.currentPosition,
    required this.estimatedWaitingTime,
  });

  factory QueueItem.fromJson(Map<String, dynamic> json) {
    return QueueItem(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceId: json['serviceId'] as String,
      currentPosition: json['currentPosition'] as int,
      estimatedWaitingTime: Duration(seconds: json['estimatedWaitingTime'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'currentPosition': currentPosition,
      'estimatedWaitingTime': estimatedWaitingTime.inSeconds,
    };
  }

  @override
  String toString() {
    return 'QueueItem{id: $id, userId: $userId, position: $currentPosition}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
