import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/core/enums/themes.dart';
import 'package:courtly/data/repository/local/theme_repository.dart';
import 'package:flutter/material.dart';

/// [ThemeProvider] is a provider class that contains the theme data for the app.
/// It is used to manage the theme data of the app.
class ThemeProvider extends ChangeNotifier {
  /// [_currentTheme] is the current theme of the app.
  ThemeData _currentTheme = AppThemes.light;

  /// [_themeRepository] is the repository class that manages the theme data.
  final ThemeRepository _themeRepository;

  ThemeProvider(this._themeRepository) {
    _loadTheme();
  }

  ThemeData get currentTheme => _currentTheme;

  /// [setLightTheme] is a method that sets the light theme of the app.
  void setLightTheme() async {
    _currentTheme = AppThemes.light;

    await _themeRepository.setThemeMode(Themes.light.label);

    notifyListeners();
  }

  /// [setDarkTheme] is a method that sets the dark theme of the app.
  void setDarkTheme() async {
    _currentTheme = AppThemes.dark;

    await _themeRepository.setThemeMode(Themes.dark.label);

    notifyListeners();
  }

  /// [_loadTheme] is a method that loads the theme of the app.
  void _loadTheme() async {
    /// [themeMode] is the theme mode of the app.
    final themeMode = await _themeRepository.getThemeMode();

    /// [themes] is a map that contains the theme data of the app.
    final Map<String, ThemeData> themes = {
      Themes.light.label: AppThemes.light,
      Themes.dark.label: AppThemes.dark,
    };

    // Set the current theme based on the theme mode
    _currentTheme = themes[themeMode] ?? AppThemes.light;

    notifyListeners();
  }
}
