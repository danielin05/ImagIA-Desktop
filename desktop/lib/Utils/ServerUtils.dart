import 'dart:convert';
import 'package:desktop/model/userModel.dart';
import 'package:http/http.dart' as http;

class ServerUtils {
  static String baseUrl = '';
  static String apiKey = '';

  static Future<(bool success, String? key, String error)> login(String username, String password) async {
    bool success = false;
    String? key;
    String error = '';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/admin/usuaris/login'),
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
        print(jsonResponse);
        success = true;
        key = jsonResponse['data']['apiKey'];
        apiKey = key!;
      } else {
        success = false;
        Map<String, dynamic> body = jsonDecode(response.body);
        error = body['message'] ?? '';
      }
    } catch (e) {
      success = false;
      error = e.toString();
    }
    return (success, key, error);
  }

  static Future<(bool success, List<UserModel> data, String error)> getUsers() async {
    bool success = false;
    List<UserModel> data = [];
    String error = '';

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/admin/usuaris'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      );
      print('Bearer $apiKey');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        success = true;
        List<dynamic> users = jsonResponse['data'] ?? [];
        print(users);
        for (Map<String, dynamic> user in users) {
          print(user);
          data.add(UserModel.fromJson(user));
        }
      } else {
        success = false;
        Map<String, dynamic> body = jsonDecode(response.body);
        error = body['message'] ?? '';
      }
    } catch (e) {
      success = false;
      error = e.toString();
    }

    return (success, data, error);
  }

  static Future<(bool success, String error)> changePlan(int id, String plan) async {
    bool success = false;
    String error = '';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/admin/usuaris/plan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'plan': plan,
          'id': id.toString(),
        }),
      );

      if (response.statusCode == 200) {
        success = true;
      } else {
        success = false;
        Map<String, dynamic> body = jsonDecode(response.body);
        error = body['message'] ?? '';
      }
    } catch (e) {
      success = false;
      error = e.toString();
    }
    return (success, error);
  }
}