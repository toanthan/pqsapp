import 'dart:convert';

class UserModel {
  int id;
  bool admin;
  String key;

  static UserModel fromJson(String jsonString) {
    final dynamic data = jsonDecode(jsonString);
    return UserModel()
      ..id = data['id']
      ..admin = data['admin']
      ..key = data['key']
    ;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'admin': admin,
    'key': key,
  };
}
