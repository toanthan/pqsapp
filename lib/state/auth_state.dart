import 'package:flutter/cupertino.dart';

class AuthState with ChangeNotifier {
  int userId;

  void updateAuth(int userId) {
    this.userId = userId;
    notifyListeners();
  }

  void cleanAuth() {
    this.userId = null;
    notifyListeners();
  }
}
