import 'package:flutter/material.dart';
import 'package:desktop/Utils/ServerUtils.dart';

class LoginProvider extends ChangeNotifier {
  String? apiKey;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> login(String url, String username, String password) async {
    isLoading = true;
    errorMessage = ''; 
    apiKey = null;
    ServerUtils.baseUrl = url;
    notifyListeners();  

    final (bool success, String key, String error) = await ServerUtils.login(username, password);
    if (success) {
      apiKey = key;  
    } else {
      errorMessage = error;
    }

    isLoading = false;
    notifyListeners();  
  }

}