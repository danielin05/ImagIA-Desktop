import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerUtils {
  static String baseUrl = '';

  static Future<(bool success, String key, String error)> login(String username, String password) async {
    bool success = false;
    String key = '';
    String error = '';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        success = true;
        key = jsonResponse['key'] ?? '';
      } else {
        success = false;
      }
    } catch (e) {
      success = false;
      key = '';
      error = e.toString();
    }
    return (success, key, error);
  }
}