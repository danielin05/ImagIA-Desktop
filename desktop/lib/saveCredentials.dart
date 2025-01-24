import 'dart:convert'; // Para manejar JSON
import 'dart:io'; // Para manejar archivos
import 'package:flutter/material.dart';

class SaveCredentials extends ChangeNotifier {
  // Método para guardar las credenciales como un JSON
  Future<void> saveCredentials(String url, String username) async {
    // Crear el mapa con los datos del usuario
    Map<String, String> userCredentials = {
      'url': url,
      'username': username,
    };

    // Convertir el mapa a un JSON string
    String jsonString = jsonEncode(userCredentials);

    // Ruta del archivo para guardar (puedes personalizar esta ruta)
    String filePath = 'lib/registros/user_credentials.json';

    // Guardar el archivo JSON
    try {
      final file = File(filePath);
      await file.writeAsString(jsonString, mode: FileMode.write);
      print('Archivo JSON guardado correctamente en $filePath');
    } catch (e) {
      print('Error al guardar el archivo JSON: $e');
    }
  }
  
  void saveUserCredentials(String url, String username) async {
    // Crear instancia de SaveCredentials
    SaveCredentials saveCredentials = SaveCredentials();

    
    await saveCredentials.saveCredentials(url, username);
  }

}
