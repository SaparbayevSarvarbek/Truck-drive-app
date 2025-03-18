import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String key = "themeMode";


  static Future<void> saveTheme(int themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, themeMode);
  }

  static Future<int> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }
}
