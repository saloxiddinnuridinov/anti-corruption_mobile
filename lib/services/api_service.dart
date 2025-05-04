import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ApiService {
  final String baseUrl = AppConstants.websiteUrl;

  // Test rejimi - har doim muvaffaqiyatli javob qaytaradi
  Future<dynamic> get(String endpoint, {String? token}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Test ma'lumotlari
    if (endpoint == 'v1/appeal/types') {
      return [
        {"id": 1, "name": "Pora", "description": "Poraxo'rlik holatlari"},
        {"id": 2, "name": "Yo'l harakati", "description": "Qoidabuzarliklar"},
        {"id": 3, "name": "Nepotizm", "description": "Qarindosh-urug'chilik"},
      ];
    } else if (endpoint == 'v1/user') {
      return {
        "id": 1,
        "one_id": "123",
        "name": "Test User",
        "email": "test@example.com",
        "phone": "+998901234567",
        "role": "user",
        "is_blocked": false,
        "warning_count": 0
      };
    }

    return {};
  }

  Future<dynamic> post(String endpoint, dynamic body, {String? token}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Test ma'lumotlari
    if (endpoint == 'v1/login' || endpoint == 'v1/register') {
      return {
        "user": {
          "id": 1,
          "one_id": body['one_id'] ?? "123",
          "name": body['name'] ?? "Test User",
          "email": "${body['one_id']}@example.com",
          "phone": body['phone'] ?? "+998901234567",
          "role": "user",
          "is_blocked": false,
          "warning_count": 0
        },
        "access_token": "test_token_${DateTime.now().millisecondsSinceEpoch}",
        "token_type": "Bearer"
      };
    }

    return {"status": "success"};
  }

  void _showError(String message) {
    debugPrint("API Error: $message");
  }
}