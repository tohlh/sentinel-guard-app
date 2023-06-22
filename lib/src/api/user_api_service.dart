import 'dart:convert';
import 'package:sentinel_guard_app/src/api/auth_api_client.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
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

  static Future<List<Bank>> getBanksList() async {
    final response = await AuthApiClient.authGet('user/get_banks');
    if (response.statusCode == 200) {
      return jsonDecode(response.body).map((e) => Bank.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load banks list');
    }
  }
}
