import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:next_elect/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userRole;

  bool get isAuthenticated => _isAuthenticated;
  String? get userRole => _userRole;

  AuthProvider() {
    checkAuth();
  }

  // Check if the user is authenticated
  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.containsKey('token');
    if (_isAuthenticated) {
      _userRole = prefs.getString('role');
    }
    notifyListeners();
  }

  // Register a new user
  Future<void> register(String username, String password, String role) async {
    try {
      final response = await ApiService.post('api/auth/register', {
        'username': username,
        'password': password,
        'role': role,
      });

      // Safely check if the token and role exist in the response
      if (response['token'] != null && response['role'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response['token']);
        await prefs.setString('role', response['role']);
        _isAuthenticated = true;
        _userRole = response['role'];
        notifyListeners();
      } else {
        throw Exception('Invalid response from server, missing token or role');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Login an existing user
  Future<void> login(String username, String password) async {
    try {
      final response = await ApiService.post('api/auth/login', {
        'username': username,
        'password': password,
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
      await prefs.setString('role', response['role']);
      _isAuthenticated = true;
      _userRole = response['role'];
      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Logout the current user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    _isAuthenticated = false;
    _userRole = null;
    notifyListeners();
  }
}