import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import '../models/user.dart'; // Your custom User model

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUserFromFirebase();
  }

  // Load user from Firebase on startup
  void _loadUserFromFirebase() {
    final fbUser = fb.FirebaseAuth.instance.currentUser;
    if (fbUser != null) {
      _user = User(email: fbUser.email!);
    }
    notifyListeners();
  }

  // Login with Firebase
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = User(email: email);
      return null; // success
    } on fb.FirebaseAuthException catch (e) {
      return e.message; // return error message
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register with Firebase
  Future<String?> register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    notifyListeners();

    if (password != confirmPassword) {
      _isLoading = false;
      notifyListeners();
      return "Passwords do not match.";
    }

    try {
      await fb.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = User(email: email);
      return null; // success
    } on fb.FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    await fb.FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
