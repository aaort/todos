import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/theme/constants.dart';

class ThemeModeManager extends StateNotifier<ThemeMode> {
  ThemeModeManager() : super(ThemeMode.system) {
    _initThemeMode();
  }

  Future<void> _initThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDark') == true) {
      state = ThemeMode.dark;
      SystemChrome.setSystemUIOverlayStyle(kOverlayDarkStyle);
    } else {
      state = ThemeMode.light;
      SystemChrome.setSystemUIOverlayStyle(kOverlayStyle);
    }
    SystemChrome.setSystemUIOverlayStyle(kOverlayStyle);
  }

  toggleTheme([ThemeMode? mode]) async {
    state =
        mode ?? (state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', state == ThemeMode.dark);
  }
}
