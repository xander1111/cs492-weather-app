import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier { 
  bool _darkMode = false;

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
    notifyListeners();
  }
}