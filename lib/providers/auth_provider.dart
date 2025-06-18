import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUserFromPrefs();
  }

  //Loading the user from the prefs
  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    if (email != null) {
      _user = User(email: email);
      notifyListeners();
    }
  }

  //Login functionality
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString('registered_email');
    final savedPassword = prefs.getString('registered_password');

    if (email == savedEmail && password == savedPassword) {
      _user = User(email: email);
      await prefs.setString('user_email', email);
    }

    _isLoading = false;
    notifyListeners();
  }

  //Register function
  Future<String?> register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    if (password != confirmPassword) {
      _isLoading = false;
      notifyListeners();
      return "Passwords do not match.";
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('registered_email', email);
    await prefs.setString('registered_password', password);

    _user = User(email: email);
    await prefs.setString('user_email', email);

    _isLoading = false;
    notifyListeners();
    return null; // Success
  }

  //Logout function
  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    notifyListeners();
  }
}
