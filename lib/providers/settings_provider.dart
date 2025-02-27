import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const defaultLightModeSeedColor = 0xff0000ff;
  static const defaultDarkModeSeedColor = 0xff0000ff;

  bool _darkMode = false;
  int _lightModeSeedColor = defaultLightModeSeedColor;
  int _darkModeSeedColor = defaultDarkModeSeedColor;
  SharedPreferences? prefs;

  bool get darkMode => _darkMode;
  int get lightModeSeedColor => _lightModeSeedColor;
  int get darkModeSeedColor => _darkModeSeedColor;

  set lightModeSeedColor(int value) {
    _lightModeSeedColor = value;
    prefs?.setInt('lightModeSeedColor', value);
    notifyListeners();
  }

  set darkModeSeedColor(int value) {
    _darkModeSeedColor = value;
    prefs?.setInt('darkModeSeedColor', value);
    notifyListeners();
  }

  void toggleMode() {
    _darkMode = !_darkMode;
    if (prefs != null) {
      prefs!.setBool('darkMode', _darkMode);
    }

    notifyListeners();
  }

  SettingsProvider() {
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _darkMode = prefs!.getBool('darkMode') ?? false;
      _lightModeSeedColor = prefs!.getInt('lightModeSeedColor') ?? defaultLightModeSeedColor;
      _darkModeSeedColor = prefs!.getInt('darkModeSeedColor') ?? defaultDarkModeSeedColor;
    }
    notifyListeners();
  }
}
