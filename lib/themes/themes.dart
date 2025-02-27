import 'package:flutter/material.dart';

class Themes {
  // ThemeData lightTheme = ThemeData(
  //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
  //   brightness: Brightness.light,
  //   useMaterial3: true,
  // );

  // ThemeData darkTheme = ThemeData(
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: Colors.blue,
  //     brightness: Brightness.dark),
  //   useMaterial3: true,
  // );

  static ThemeData lightTheme(int seedColor) => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(seedColor)),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static ThemeData darkTheme(int seedColor) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(seedColor),
      brightness: Brightness.dark),
    useMaterial3: true,
  );
}
