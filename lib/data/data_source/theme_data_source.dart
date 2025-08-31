import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataSource {
  static final String themeKey = 'isDark';

  static void saveTheme(bool isDark) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(themeKey, isDark);
  }

  static Future<bool> getTheme() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(themeKey) ?? false;
  }
}
