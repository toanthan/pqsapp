import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  Future<String> getAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("auth");
  }

  Future<bool> setAuth(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("auth", value);
  }
}
