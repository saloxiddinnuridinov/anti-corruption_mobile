import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Future<bool> login(String oneId) async {
    try {
      final response = await _apiService.post('v1/login', {'one_id': oneId});

      if (response != null) {
        _user = User.fromJson(response['user']);
        _token = response['access_token'];

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

  Future<bool> updateProfile({
    required String name,
    String? phone,
    String? email,
  }) async {
    try {
      final response = await _apiService.post(
        'v1/profile/update',
        {
          'name': name,
          'phone': phone,
          'email': email,
        },
        token: _token,
      );

      if (response != null) {
        _user = User.fromJson(response['user']);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}