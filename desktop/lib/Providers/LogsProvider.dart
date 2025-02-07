import 'package:desktop/Utils/ServerUtils.dart';
import 'package:flutter/material.dart';
import 'package:desktop/model/LogModel.dart';

class LogsProvider extends ChangeNotifier {
  String messageFilter = '';
  String tagFilter = '';
  List<LogModel> logs = [];

  Future<void> loadLogs() async {
    logs = [];
    var result = await ServerUtils.getLogs(messageFilter, tagFilter);
    print(result);
    bool success = result.$1;
    if (success) {
      logs = result.$2;
    } else {
      print(result.$3);
    }
    notifyListeners(); // Notifica a los widgets que deben actualizarse
  }
}