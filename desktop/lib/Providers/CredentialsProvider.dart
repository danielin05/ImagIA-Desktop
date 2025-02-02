import 'dart:convert'; // Para manejar JSON
import 'dart:io'; // Para manejar archivos
import 'package:flutter/material.dart';

class CredentialsProvider extends ChangeNotifier {
  String _url = '';
  String _username = '';
  String _apiKey = '';  // Nueva variable para apiKey

  // Getters
  String get url => _url;
  String get username => _username;
  String get apiKey => _apiKey;  // Nuevo getter

  // Método para actualizar las credenciales
  Future<void> updateCredentials(String url, String username, String apiKey) async {
    _url = url;
    _username = username;
    _apiKey = apiKey;
    notifyListeners();
    await _saveToFile();
  }

  // Método privado para guardar las credenciales como un JSON
  Future<void> _saveToFile() async {
    Map<String, String> userCredentials = {
      'url': _url,
      'username': _username,
      'apiKey': _apiKey,  // Agregado apiKey al mapa
    };

    String jsonString = jsonEncode(userCredentials);
    String filePath = 'lib/registros/user_credentials.json';

    try {
      final file = File(filePath);
      await file.writeAsString(jsonString, mode: FileMode.write);
      print('Archivo JSON guardado correctamente en $filePath');
    } catch (e) {
      print('Error al guardar el archivo JSON: $e');
    }
  }

  // Método para cargar las credenciales iniciales
  Future<void> loadInitialCredentials() async {
    String filePath = 'lib/registros/user_credentials.json';
    try {
      final file = File(filePath);
      if (await file.exists()) {
        String jsonString = await file.readAsString();
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        _url = jsonData['url'] ?? '';
        _username = jsonData['username'] ?? '';
        _apiKey = jsonData['apiKey'] ?? '';  // Cargando apiKey
        notifyListeners();
      }
    } catch (e) {
      print('Error al cargar el archivo JSON: $e');
      _url = '';
      _username = '';
      _apiKey = '';  // Limpiando apiKey en caso de error
      notifyListeners();
    }
  }

  // Método para limpiar las credenciales
  void clearCredentials() {
    _url = '';
    _username = '';
    _apiKey = '';  // Limpiando apiKey
    notifyListeners();
    _saveToFile(); // También limpia el archivo
  }
}
