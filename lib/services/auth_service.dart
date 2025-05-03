import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User? _user;
  String? _token;
  final ApiService _apiService = ApiService();

  User? get user => _user;
  String? get token => _token;

  Future<bool> login(String oneId) async {
    try {
      final response = await _apiService.post('v1/login', {'one_id': oneId});

      if (response != null) {
        _user = User.fromJson(response['user']);
        _token = response['access_token'];

        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String oneId, String name, String? phone) async {
    try {
      final response = await _apiService.post('v1/register', {
        'one_id': oneId,
        'name': name,
        'phone': phone,
      });

      if (response != null) {
        _user = User.fromJson(response['user']);
        _token = response['access_token'];

        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      _token = token;
      // Fetch user data
      final response = await _apiService.get('v1/user', token: token);

      if (response != null) {
        _user = User.fromJson(response);
        notifyListeners();
        return true;
      }
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