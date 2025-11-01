
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String userId, String password) async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 1));

    if (userId == 'Demo' && password == '1234') {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
