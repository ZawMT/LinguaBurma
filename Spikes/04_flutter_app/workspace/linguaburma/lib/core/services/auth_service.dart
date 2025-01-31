import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  // Save JWT token securely
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Get stored token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Check if user is logged in by verifying token
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout and clear secure storage
  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }
}
