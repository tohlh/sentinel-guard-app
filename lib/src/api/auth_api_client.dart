import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sentinel_guard_app/src/auth/auth_service.dart';

class AuthApiClient {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';

  static Future authGet(String url) async {
    String token = await AuthService.getToken();
    return http.get(Uri.parse('$apiBaseUrl/$url'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  static Future authPost(String url, data) async {
    String token = await AuthService.getToken();
    return http.post(
      Uri.parse('$apiBaseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }

  static Future authPatch(String url, data) async {
    String token = await AuthService.getToken();
    return http.patch(
      Uri.parse('$apiBaseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }

  static Future authDelete(String url, data) async {
    String token = await AuthService.getToken();
    return http.delete(
      Uri.parse('$apiBaseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }
}
