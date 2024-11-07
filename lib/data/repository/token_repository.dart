import 'package:courtly/core/enums/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [TokenRepository] is a repository class that contains the auth token data for the app.
/// It is used to manage the auth token data.
class TokenRepository {
  /// [getToken] is a method that returns the auth token from the shared preferences.
  /// It is used to get the auth token from the shared preferences.
  ///
  /// Returns a [Future] of [String].
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(PrefsKeys.authToken.value);
  }

  /// [setToken] is a method that sets the auth token in the shared preferences.
  /// It is used to set the auth token in the shared preferences.
  ///
  /// Returns a [Future] of [void].
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(PrefsKeys.authToken.value, token);
  }

  /// [clearToken] is a method that clears the auth token from the shared preferences.
  /// It is used to clear the auth token from the shared preferences.
  ///
  /// Returns a [Future] of [void].
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(PrefsKeys.authToken.value);
  }
}
