import 'package:flutter/material.dart';
import 'package:todo_application/services/dark_theme_prefs.dart';

class DarkThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  DarkThemePrefs darkThemePrefs = DarkThemePrefs();

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
