import 'package:flutter/foundation.dart';
import 'package:shared_preferences.dart';
import '../models/service.dart';
import '../models/category.dart';
import '../services/service_service.dart';

class ServiceProvider with ChangeNotifier {
  final ServiceService _serviceService;
  final SharedPreferences _prefs;

  List<Service> _services = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  ServiceProvider(this._serviceService, this._prefs);

  // Getters
  List<Service> get services => _services;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get services by category
  List<Service> getServicesByCategory(String categoryId) {
    return _services.where((service) => service.categoryId == categoryId).toList();
  }

  Future<void> fetchServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Try to get cached data first
      final cachedData = _prefs.getString('cached_services');
      if (cachedData != null) {
        // Parse and use cached data while fetching fresh data
        // Implementation will be added when service_service is created
      }

      final services = await _serviceService.getServices();
      _services = services;
      
      // Cache the new data
      // await _prefs.setString('cached_services', jsonEncode(services));
      
      _error = null;
    } catch (e) {
      _error = 'Failed to fetch services: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await _serviceService.getCategories();
      _categories = categories;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch categories: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<Service?> getServiceById(String id) async {
    try {
      // First check in local list
      final localService = _services.firstWhere(
        (service) => service.id == id,
        orElse: () => throw Exception('Service not found locally'),
      );
      return localService;
    } catch (_) {
      // If not found locally, fetch from API
      try {
        final service = await _serviceService.getServiceById(id);
        return service;
      } catch (e) {
        _error = 'Failed to get service details: ${e.toString()}';
        notifyListeners();
        return null;
      }
    }
  }

  // Admin operations
  Future<void> addService(Service service) async {
    try {
      final newService = await _serviceService.addService(service);
      _services.add(newService);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to add service: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateService(Service service) async {
    try {
      await _serviceService.updateService(service);
      final index = _services.indexWhere((s) => s.id == service.id);
      if (index != -1) {
        _services[index] = service;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to update service: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await _serviceService.deleteService(serviceId);
      _services.removeWhere((s) => s.id == serviceId);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to delete service: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
