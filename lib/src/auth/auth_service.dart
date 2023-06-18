import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static Future<bool> loggedIn() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt') ?? '';
    if (token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'jwt') ?? '';
  }

  static void removeToken() {
    const storage = FlutterSecureStorage();
    storage.delete(key: 'jwt');
  }

  static void saveToken(String token) {
    const storage = FlutterSecureStorage();
    storage.write(key: 'jwt', value: token);
  }
}
