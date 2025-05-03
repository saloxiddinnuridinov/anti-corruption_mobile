import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  // Test rejimi - har qanday kirishga ruxsat beradi
  Future<bool> login(String oneId) async {
    try {
      // Test foydalanuvchi ma'lumotlari
      _user = User(
        id: 1,
        oneId: oneId,
        name: "Test User",
        email: "test@example.com",
        phone: "+998901234567",
        role: "user",
        isBlocked: false,
        warningCount: 0,
      );

      _token = "test_token_${DateTime.now().millisecondsSinceEpoch}";

      // Saqlash (test rejimida)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String oneId, String name, String? phone) async {
    try {
      // Test foydalanuvchi ma'lumotlari
      _user = User(
        id: 2,
        oneId: oneId,
        name: name,
        email: "$oneId@example.com",
        phone: phone ?? "+998901234567",
        role: "user",
        isBlocked: false,
        warningCount: 0,
      );

      _token = "test_token_${DateTime.now().millisecondsSinceEpoch}";

      // Saqlash (test rejimida)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      _token = token;
      _user = User(
        id: 1,
        oneId: "123",
        name: "Test User",
        email: "test@example.com",
        phone: "+998901234567",
        role: "user",
        isBlocked: false,
        warningCount: 0,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    _user = null;
    _token = null;
    notifyListeners();
  }
}