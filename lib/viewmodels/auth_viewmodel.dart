
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class AuthViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isAuthCheckComplete = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isAuthCheckComplete => _isAuthCheckComplete;

  final DatabaseHelper _db = DatabaseHelper.instance;

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

  Future<void> tryAutoLogin() async {
    final user = await _db.getUser();
    _isAuthenticated = user != null;
    _isAuthCheckComplete = true;
    notifyListeners();
  }
}
