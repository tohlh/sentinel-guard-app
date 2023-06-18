import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sentinel_guard_app/src/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApiClient {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';

  static Future getWithBearer(String url, String token) {
    return http.get(Uri.parse('$apiBaseUrl/$url'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  static Future<String> login(String email, String password) async {
    try {
      final res = await http.post(Uri.parse('$apiBaseUrl/auth/user/login'),
          body: {"email": email, "password": password});
      final respondBody = jsonDecode(res.body);
      final token = respondBody['access_token'];
      const storage = FlutterSecureStorage();
      await storage.write(key: 'jwt', value: token);
      return token;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  static Future<User> getUserProfile() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt') ?? '';
    final response = await getWithBearer('auth/user/profile', token);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
