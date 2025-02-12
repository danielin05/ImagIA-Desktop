import 'dart:convert';
import 'package:desktop/model/BarGraphData.dart';
import 'package:desktop/model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:desktop/model/LogModel.dart';

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

  static Future<(bool success, String error)> changeQuota(int id, String quota) async {
    bool success = false;
    String error = '';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/admin/usuaris/quota'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'quota': quota.toString(),
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

  static Future<(bool success, List<LogModel> data, String error)> getLogs(String messageFilter, String tagFilter) async {
    bool success = false;
    List<LogModel> data = [];
    String error = '';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/admin/logs/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'messageFilter': messageFilter,
          'tagFilter': tagFilter,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse $jsonResponse");
        success = true;
        List<dynamic> logs = jsonResponse['data'] ?? [];
        print(logs);
        for (Map<String, dynamic> log in logs) {
          print(log);
          data.add(LogModel.fromJson(log));
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

  static Future<(bool success, BarGraphData data, String error)> getRequests() async {
    bool success = false;
    BarGraphData data = const BarGraphData(values: [], labels: [], maxValue: 0);
    String error = '';

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/admin/requests/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        success = true;
        List<dynamic> requests = jsonResponse['data'] ?? [];
        print(requests);
        List<int> values = [];
        List<String> labels = [];
        for (Map<String, dynamic> request in requests) {
          //[{tag: ERROR, total: 11}, {tag: Find Users, total: 9}, {tag: Login, total: 1}]
          values.add(int.parse(request['total'].toString()));
          labels.add(request['tag']);
        }
        data = BarGraphData(values: values, labels: labels, maxValue: values.reduce((a, b) => a > b ? a : b));
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
}