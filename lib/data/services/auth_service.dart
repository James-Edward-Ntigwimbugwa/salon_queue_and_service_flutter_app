import 'package:dio/dio.dart';
import '../../core/constants.dart';
import '../models/user.dart';

class AuthService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Initialize Dio with interceptors for logging and error handling
  static void initializeDio({String? token}) {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        // Handle common error scenarios
        if (error.response?.statusCode == 401) {
          // Handle unauthorized access
          throw Exception('Unauthorized access. Please login again.');
        }
        return handler.next(error);
      },
    ));
  }

  // Login user
  static Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        AppConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = User.fromJson(response.data);
        // Initialize Dio with the new token
        initializeDio(token: user.token);
        return user;
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during login';
      
      if (e.response?.data != null && e.response?.data['detail'] != null) {
        errorMessage = e.response?.data['detail'];
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Please check your internet connection.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server is not responding. Please try again later.';
      }
      
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      await _dio.post(AppConstants.logout);
      // Clear the token after logout
      initializeDio();
    } on DioException catch (e) {
      throw Exception('Failed to logout: ${e.message}');
    }
  }

  // Get user profile
  static Future<User> getProfile() async {
    try {
      final response = await _dio.get(AppConstants.profile);
      
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to get profile');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get profile: ${e.message}');
    }
  }

  // Update user profile
  static Future<User> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _dio.patch(
        AppConstants.updateProfile,
        data: profileData,
      );
      
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to update profile');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update profile: ${e.message}');
    }
  }

  // Change password
  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        AppConstants.changePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
    } on DioException catch (e) {
      throw Exception('Failed to change password: ${e.message}');
    }
  }
}
