import 'package:flutter/material.dart';
import 'package:desktop/model/UserModel.dart';
import 'package:desktop/Utils/ServerUtils.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];
  String errorMessage = '';

  Future<void> loadUsers() async {
    errorMessage = '';
    users = [];
    var result = await ServerUtils.getUsers();
    bool success = result.$1;
    if (success) {
      users = result.$2;
    } else {
      print(result.$3);
      errorMessage = result.$3;
    }
    notifyListeners(); // Notifica a los widgets que deben actualizarse
  }
}
