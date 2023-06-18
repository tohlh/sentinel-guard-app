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

  static Future authPost(String url) async {
    String token = await AuthService.getToken();
    return http.post(Uri.parse('$apiBaseUrl/$url'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}
