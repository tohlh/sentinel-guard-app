import 'dart:convert';
import 'package:sentinel_guard_app/src/api/auth_api_client.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/models/message.dart';
import 'package:sentinel_guard_app/src/models/user.dart';
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
    final response = await AuthApiClient.authPost('user/add_bank', {
      "bankKey": bankKey,
    });

    if (response.statusCode != 201) {
      throw Exception('Failed to add bank');
    }
  }

  static Future updatePublicKey(String publicKey) async {
    final response = await AuthApiClient.authPatch('user/update_public_key', {
      "publicKey": publicKey,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to update public key');
    }
  }
}
