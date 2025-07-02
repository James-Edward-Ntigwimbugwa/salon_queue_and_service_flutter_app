import 'package:dio/dio.dart';
import '../models/product.dart';
import '../../core/constants.dart';

class InventoryService {
  final Dio _dio;

  InventoryService(this._dio);

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get(ApiConstants.products);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> updateStock(String productId, int newStock) async {
    try {
      final response = await _dio.patch(
        '${ApiConstants.products}/$productId/stock',
        data: {'stock': newStock},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update stock');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Product> addProduct(Product product) async {
    try {
      final response = await _dio.post(
        ApiConstants.products,
        data: product.toJson(),
      );

      if (response.statusCode == 201) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.products}/${product.id}',
        data: product.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final response = await _dio.delete(
        '${ApiConstants.products}/$productId',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
