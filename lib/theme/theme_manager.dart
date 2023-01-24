import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/theme/constants.dart';

class ThemeModeManager extends StateNotifier<ThemeMode?> {
  ThemeModeManager() : super(null) {
    // Initialize theme mode
    getThemeMode();
  }

  /// Initializes theme mode and returns the current state of type [ThemeMode]
  Future<ThemeMode?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isThemeModeDark = prefs.getBool('isThemeModeDark');
    final themeMode =
        isThemeModeDark ?? true ? ThemeMode.dark : ThemeMode.light;
    _setThemeMode(themeMode);
    // If stored theme mode is null default theme mode will be light
    if (isThemeModeDark == null) prefs.setBool('isThemeModeDark', false);
    state = isThemeModeDark == true ? ThemeMode.dark : ThemeMode.light;
    _setThemeMode(state!);
    return state;
  }

  Future<void> _setThemeMode(ThemeMode themeMode) async {
    state = themeMode;
    SystemChrome.setSystemUIOverlayStyle(
        themeMode == ThemeMode.dark ? kOverlayStyle : kOverlayDarkStyle);
  }

  toggleTheme() async {
    _setThemeMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isThemeModeDark', state == ThemeMode.dark);
  }
}
