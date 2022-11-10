import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager() {
    _initThemeMode();
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> _initThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDark') == true) {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
    notifyListeners();
  }
}
