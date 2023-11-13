import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    secondary: Colors.blue,
    tertiary: Colors.black,
    seedColor: Colors.black,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        letterSpacing: 1.1),
    titleMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
      color: Colors.blue,
    ),
    titleSmall: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
    secondary: Colors.grey,
    seedColor: Colors.purple,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
        letterSpacing: 1.1),
    titleMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
      color: Colors.indigo,
    ),
    titleSmall: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
);

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeProvider({
    ThemeMode mode = ThemeMode.light,
  }) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
