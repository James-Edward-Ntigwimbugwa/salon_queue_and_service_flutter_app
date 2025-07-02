class User {
  final int id;
  final String email;
  final String fullName;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, fullName: $fullName)';
  }

  User copyWith({
    int? id,
    String? email,
    String? fullName,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      token: token ?? this.token,
    );
  }
}
