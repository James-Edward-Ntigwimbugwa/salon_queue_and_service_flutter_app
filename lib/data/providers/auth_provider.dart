import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

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
  Future<bool> login(String email, String password) async {
    _resetError();
    _setLoading(true);

    try {
      final userData = await AuthService.login(email, password);
      _user = userData;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
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
