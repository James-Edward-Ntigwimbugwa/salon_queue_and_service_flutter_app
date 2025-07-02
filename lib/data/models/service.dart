import 'dart:convert';

class Service {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String imageUrl;
  final double price;
  final int durationMinutes;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.imageUrl,
    required this.price,
    required this.durationMinutes,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      durationMinutes: json['durationMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'price': price,
      'durationMinutes': durationMinutes,
    };
  }

  @override
  String toString() {
    return 'Service{id: $id, name: $name, price: $price}';
  }

  bool isValid() {
    return name.isNotEmpty && price >= 0 && durationMinutes > 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Service &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
