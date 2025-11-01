
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class AuthViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  final DatabaseHelper _db = DatabaseHelper();

  Future<void> login(String username, String password) async {
    if (username == 'Demo' && password == '1234') {
      _isAuthenticated = true;
      await _db.saveUser(username, password);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final user = await _db.getUser();
    if (user != null) {
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }
}
