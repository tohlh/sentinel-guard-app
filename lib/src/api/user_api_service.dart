import 'dart:convert';
import 'package:sentinel_guard_app/src/api/auth_api_client.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/models/message.dart';
import 'package:sentinel_guard_app/src/models/user.dart';
import 'package:sentinel_guard_app/src/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserApiService {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';
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
      return jsonDecode(response.body)['banks']
          .map<Bank>((e) => Bank.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load banks list');
    }
  }

  static Future<List<Message>> getMessages(String bankCommunicationKey) async {
    final response =
        await AuthApiClient.authGet('user/get_messages/$bankCommunicationKey');
    if (response.statusCode == 200) {
      final messages = jsonDecode(response.body)['messages']
          .map<Message>((e) => Message.fromJson(e))
          .toList();
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

   static Future addBank(String bankKey) async {
    dynamic res;
    try {
    String token = await AuthService.getToken();
    res = await http.post(Uri.parse('$apiBaseUrl/user/add_bank'),
          body: {"bankKey": bankKey},
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }
          );
    } catch (e) {
      print(e.toString());
      // throw Exception('Failed to add bank?');
    }
    return res;
    // return http.post(Uri.parse('$apiBaseUrl/$url'), headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    // });
  }
}
