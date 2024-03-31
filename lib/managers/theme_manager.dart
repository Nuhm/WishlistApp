import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeData _themeData = _lightTheme;
  ThemeType _currentTheme = ThemeType.light;

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    // Define your light theme properties here
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    // Define your dark theme properties here
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
