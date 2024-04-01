import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeData _themeData = _darkTheme;
  ThemeType _currentTheme = ThemeType.dark;

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.red,
    surface: Colors.white,
    background: Color(0xFFF5F5F5),
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: Colors.blue,
    secondary: Colors.red,
    surface: Color(0xFF2C2F33),
    background: Color(0xFF23272A),
  );

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
  );

  ThemeData get themeData => _themeData;

  ThemeType get currentTheme => _currentTheme;

  void toggleDarkMode() {
    if (_currentTheme == ThemeType.light) {
      _themeData = _darkTheme;
      _currentTheme = ThemeType.dark;
    } else {
      _themeData = _lightTheme;
      _currentTheme = ThemeType.light;
    }
    notifyListeners();
  }
}