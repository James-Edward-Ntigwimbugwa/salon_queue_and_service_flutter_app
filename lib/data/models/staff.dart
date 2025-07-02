class Staff {
  final String id;
  final String name;
  final String role;
  final String profileImage;
  final double rating;
  final Map<String, dynamic> performanceMetrics;

  Staff({
    required this.id,
    required this.name,
    required this.role,
    required this.profileImage,
    required this.rating,
    required this.performanceMetrics,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      profileImage: json['profileImage'] as String,
      rating: (json['rating'] as num).toDouble(),
      performanceMetrics: json['performanceMetrics'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'profileImage': profileImage,
      'rating': rating,
      'performanceMetrics': performanceMetrics,
    };
  }

  @override
  String toString() {
    return 'Staff{id: $id, name: $name, role: $role, rating: $rating}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Staff &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
