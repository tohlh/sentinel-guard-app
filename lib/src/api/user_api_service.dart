import 'dart:convert';

import 'package:sentinel_guard_app/src/api/auth_api_client.dart';
import 'package:sentinel_guard_app/src/models/user.dart';

class UserApiService {
  static Future<User> getUserProfile() async {
    final response = await AuthApiClient.authGet('auth/user/profile');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
