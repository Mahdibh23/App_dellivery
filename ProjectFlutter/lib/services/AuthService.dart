import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    try {
      await storage.write(key: 'auth_token', value: token);
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  static Future<String?> getToken() async {
    try {
      return await storage.read(key: 'auth_token');
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  static Future<void> deleteToken() async {
    try {
      await storage.delete(key: 'auth_token');
    } catch (e) {
      print('Error deleting token: $e');
    }
  }

  static Future<bool> isAuthenticated() async {
    try {
      String? token = await getToken();
      return token != null;
    } catch (e) {
      print('Error checking authentication: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    try {
      await deleteToken();
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
