class Product {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String imageUrl;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
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
      'stock': stock,
    };
  }

  bool isInStock() {
    return stock > 0;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, stock: $stock}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
