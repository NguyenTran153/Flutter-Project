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
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
    secondary: Colors.grey,
    tertiary: Colors.purple,
    seedColor: Colors.purple,
    brightness: Brightness.dark,
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
