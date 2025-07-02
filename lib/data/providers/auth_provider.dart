import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  final AuthService _authService = AuthService();

  // Reset error message
  void _resetError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Login
  Future<bool> login(String username, String password) async {
    _resetError();
    _setLoading(true);

    try {
      final userData = await AuthService.login(username, password);
      _user = userData;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register(
    String username,
    String email,
    String firstName,
    String lastName,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    _setLoading(true);
    _setError(null);

    try {
      final result = await _authService.register(
        username,
        email,
        firstName,
        lastName,
        phoneNumber,
        password,
        confirmPassword,
      );

      if (result['success']) {
        _setLoading(false);
        return true;
      } else {
        _setError(result['error']);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      _setLoading(false);
      return false;
    }
  }

  // Logout
  Future<bool> logout() async {
    _resetError();
    _setLoading(true);

    try {
      await AuthService.logout();
      _user = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // Get Profile
  Future<bool> fetchProfile() async {
    if (!isAuthenticated) return false;

    _resetError();
    _setLoading(true);

    try {
      final userData = await AuthService.getProfile();
      _user = userData;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // Update Profile
  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    if (!isAuthenticated) return false;

    _resetError();
    _setLoading(true);

    try {
      final updatedUser = await AuthService.updateProfile(profileData);
      _user = updatedUser;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // Change Password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!isAuthenticated) return false;

    _resetError();
    _setLoading(true);

    try {
      await AuthService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // Clear all data (used when logging out or when auth token expires)
  void clearData() {
    _user = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
