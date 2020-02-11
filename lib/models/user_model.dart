import 'dart:convert';

class UserModel {
  int id;
  bool admin;

  static UserModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return UserModel()
      ..id = data['id']
      ..admin = data['admin'];
  }
}
