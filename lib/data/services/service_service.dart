import 'package:dio/dio.dart';
import '../models/service.dart';
import '../models/category.dart';
import '../../core/constants.dart';

class ServiceService {
  final Dio _dio;

  ServiceService(this._dio);

  Future<List<Service>> getServices() async {
    try {
      final response = await _dio.get(ApiConstants.services);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Service.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch services');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('${ApiConstants.services}/categories');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Service> getServiceById(String id) async {
    try {
      final response = await _dio.get('${ApiConstants.services}/$id');
      
      if (response.statusCode == 200) {
        return Service.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch service details');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Service> addService(Service service) async {
    try {
      final response = await _dio.post(
        ApiConstants.services,
        data: service.toJson(),
      );

      if (response.statusCode == 201) {
        return Service.fromJson(response.data);
      } else {
        throw Exception('Failed to add service');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> updateService(Service service) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.services}/${service.id}',
        data: service.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update service');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      final response = await _dio.delete(
        '${ApiConstants.services}/$serviceId',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete service');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Category> addCategory(Category category) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.services}/categories',
        data: category.toJson(),
      );

      if (response.statusCode == 201) {
        return Category.fromJson(response.data);
      } else {
        throw Exception('Failed to add category');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.services}/categories/${category.id}',
        data: category.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      final response = await _dio.delete(
        '${ApiConstants.services}/categories/$categoryId',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete category');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
