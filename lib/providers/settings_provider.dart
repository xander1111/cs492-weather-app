import 'package:flutter/material.dart';
import 'package:weatherapp/utils/settings.dart';

class SettingsProvider extends ChangeNotifier { 
  bool _darkMode = false;
  late Settings _settings;

  SettingsProvider() {
    loadSettings();
  }

  bool get darkMode => _darkMode;
  set darkMode(value) => _darkMode = value;

  ThemeData get currentTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 143, 216, 233), 
      brightness: _darkMode ? Brightness.dark : Brightness.light,
    ),
    useMaterial3: true,
    brightness: _darkMode ? Brightness.dark : Brightness.light,
  );

  void updateDarkMode(bool value) {
    _darkMode = value;
    _settings.saveBool("darkMode", value);

    notifyListeners();
  }

  Future<void> loadSettings() async {
    _settings = await Settings.init();
    updateDarkMode(_settings.getBool("darkMode") ?? false);
    notifyListeners();
  }
}