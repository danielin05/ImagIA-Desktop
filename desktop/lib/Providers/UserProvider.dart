import 'package:flutter/material.dart';
import 'package:desktop/model/userModel.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];

  Future<void> loadUsers() async {
    await Future.delayed(const Duration(seconds: 2)); // Simula una carga de datos
    //Endpoint: /api/admin/users, devuelve todos los usuarios
    users = [
      UserModel(1, 'Oscar', 'oscar@gmail.com', 'Free'),
      UserModel(2, 'Pedro', 'pedro@gmail.com', 'Premium'),
      UserModel(3, 'Juan', 'juan@gmail.com', 'Free'),
      UserModel(4, 'Maria', 'maria@gmail.com', 'Premium'),
      UserModel(5, 'Luis', 'luis@gmail.com', 'Free'),
      UserModel(6, 'Ana', 'ana@gmail.com', 'Premium'),
    ];
    
    notifyListeners(); // Notifica a los widgets que deben actualizarse
  }
}
