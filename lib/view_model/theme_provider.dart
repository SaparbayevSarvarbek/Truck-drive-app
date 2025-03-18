import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'theme_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    int savedTheme = await ThemePreferences.getTheme();
    if (savedTheme == 0) {
      var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      _themeMode = (brightness == Brightness.dark) ? ThemeMode.dark : ThemeMode.light;
    } else if (savedTheme == 1) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    await ThemePreferences.saveTheme(isDark ? 2 : 1);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
