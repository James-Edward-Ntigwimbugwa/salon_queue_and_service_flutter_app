import 'package:flutter/foundation.dart';
import 'package:shared_preferences.dart';
import '../models/product.dart';
import '../services/inventory_service.dart';

class InventoryProvider with ChangeNotifier {
  final InventoryService _inventoryService;
  final SharedPreferences _prefs;
  
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  InventoryProvider(this._inventoryService, this._prefs);

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Try to get cached data first
      final cachedData = _prefs.getString('cached_products');
      if (cachedData != null) {
        // Parse and use cached data while fetching fresh data
        // Implementation will be added when inventory_service is created
      }

      final products = await _inventoryService.getProducts();
      _products = products;
      
      // Cache the new data
      // await _prefs.setString('cached_products', jsonEncode(products));
      
      _error = null;
    } catch (e) {
      _error = 'Failed to fetch products: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateStock(String productId, int newStock) async {
    try {
      await _inventoryService.updateStock(productId, newStock);
      
      // Update local state
      final index = _products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        // Implementation will be completed when Product model has a copyWith method
        // _products[index] = _products[index].copyWith(stock: newStock);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to update stock: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _inventoryService.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to add product: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _inventoryService.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to update product: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _inventoryService.deleteProduct(productId);
      _products.removeWhere((p) => p.id == productId);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to delete product: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
