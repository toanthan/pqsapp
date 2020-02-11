import 'package:PQSApp/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class AuthState with ChangeNotifier {
  UserModel user;
  void updateAuth(UserModel user) {
    this.user = user;
    notifyListeners();
  }

  bool hasAuth() {
    return this.user != null;
  }

  void cleanAuth() {
    this.user = null;
    notifyListeners();
  }
}
