import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/themes/themes.dart' as themes;

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  int? _darkModeColor;
  int? _lightModeColor;
  SharedPreferences? prefs;
  ThemeData? lightTheme;
  ThemeData? darkTheme;

  bool get darkMode => _darkMode;
  int? get lightModeColor => _lightModeColor;
  int? get darkModecolor => _darkModeColor;

  final Color defaultPicker = Color.fromARGB(255, 255, 255, 255);

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
    }
    initColors();
    notifyListeners();
  }

  void saveColorPrefs() {
    if (prefs != null) {
      if (_lightModeColor != null) {
        prefs!.setInt('lightModeColor', _lightModeColor!);
      }
      if (_darkModeColor != null) {
        prefs!.setInt('darkModeColor', _darkModeColor!);
      }
    }
  }

  void initColors() {
    if (prefs != null) {
      _lightModeColor = prefs!.getInt('lightModeColor');
      _darkModeColor = prefs!.getInt('darkModeColor');
      if (_lightModeColor != null) {
        setLightModeColor(Color(_lightModeColor!));
      }
      else{
        lightTheme = themes.lightTheme;
      }
      if (_darkModeColor != null) {
        setDarkModeColor(Color(_darkModeColor!));
      }
      else {
        darkTheme = themes.darkTheme;
      }
    }
  }

  void setColor(Color currentColor){
      if (_darkMode) {
        setDarkModeColor(currentColor);
      } else {
        setLightModeColor(currentColor);
      }
  }

  void setLightModeColor(Color color) {
    _lightModeColor = color.value;
    lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light),
      
      useMaterial3: true,
    );
    saveColorPrefs();
    notifyListeners();
  }

  void setDarkModeColor(Color color) {
    _darkModeColor = color.value;
    darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark),
      useMaterial3: true,
    );
    saveColorPrefs();
    notifyListeners();
  }

  Color getPickerColor(){
    if (_darkMode){
      if (_darkModeColor != null){
        return Color(_darkModeColor!);
      }
    }
    else {
      if (_lightModeColor != null){
        return Color(_lightModeColor!);
      }
    }
    return defaultPicker;
  }
}
