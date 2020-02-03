import 'package:flutter/cupertino.dart';

class ReportState with ChangeNotifier {
  int size = 0;

  void increase() {
    size++;
    notifyListeners();
  }
}
