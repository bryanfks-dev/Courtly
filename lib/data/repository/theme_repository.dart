import 'package:courtly/core/enums/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [ThemeRepository] is a repository class that contains the theme data for the app.
class ThemeRepository {
  /// [setThemeMode] is a method that sets the theme mode of the app.
  Future<void> setThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(PrefsKeys.theme.value, themeMode);
  }

  /// [getThemeMode] is a method that returns the theme mode of the app.
  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(PrefsKeys.theme.value);
  }
}
