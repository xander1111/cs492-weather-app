import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  final SharedPreferences _prefs;

  Settings({required SharedPreferences prefs}) : _prefs = prefs;

  static Future<Settings> init() async {
    return Settings(prefs: await SharedPreferences.getInstance());
  }

  void saveBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
}