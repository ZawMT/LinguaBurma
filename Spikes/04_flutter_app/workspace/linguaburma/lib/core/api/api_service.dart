// lib/core/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = 'https://your-django-server/api';

  Future<Map<String, dynamic>?> googleLogin(String idToken) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/google-login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Google login failed: ${response.body}');
        return null;
      }
    } catch (error) {
      print('API Service Error: $error');
      return null;
    }
  }
}
