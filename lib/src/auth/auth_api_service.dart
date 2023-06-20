import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentinel_guard_app/src/api/auth_api_client.dart';
import 'package:sentinel_guard_app/src/auth/auth_service.dart';

class AuthApiService {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';

  static Future login(String email, String password) async {
    try {
      final res = await http.post(Uri.parse('$apiBaseUrl/auth/user/login'),
          body: {"email": email, "password": password});
      final respondBody = jsonDecode(res.body);
      final token = respondBody['access_token'];
      AuthService.saveToken(token);
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  static Future register(String name, String email, String password, String cpassword) async {
    try {
      final res = await http.post(
        Uri.parse('$apiBaseUrl/auth/user/register'),
        body: {
          "name": name,
          "email": email, 
          "password": password, 
          "passwordConfirmation": cpassword
        }
      );
      final responseBody = jsonDecode(res.body);
      final token = responseBody['access_token'];
      AuthService.saveToken(token);
    } catch (e) {
      throw Exception('Failed to register');
    }
  }

  static Future verifyToken() async {
    try {
      final res = await AuthApiClient.authGet('auth/user/verify');
      final respondBody = jsonDecode(res.body);
      final message = respondBody['message'];
      return message == 'ok';
    } catch (e) {
      throw Exception('Failed to verify token');
    }
  }
}
