import 'package:desktop/model/BarGraphData.dart';
import 'package:desktop/Utils/ServerUtils.dart';
import 'package:flutter/material.dart';


class RequestsProvider extends ChangeNotifier {
  BarGraphData? barGetData;

  Future<void> getRequests() async {
    final (success, BarGraphData data, error) = await ServerUtils.getRequests();
    if (success) {
      barGetData = data;
      notifyListeners();
    } else {
      print(error);
    }
  }

}