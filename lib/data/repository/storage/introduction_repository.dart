import 'package:courtly/core/enums/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [IntroductionRepository] is a repository class that contains the
/// introduction data for the app.
class IntroductionRepository {
  /// [setIntroductionStatus] is a method that sets the introduction status
  /// of the app.
  ///
  /// Paramters:
  ///   - [status] is a boolean value that represents the introduction status.
  ///
  /// Returns [Future] of [void]
  Future<void> setIntroductionStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(PrefsKeys.introduction.value, status);
  }

  /// [getIntroductionStatus] is a method that returns the introduction status
  /// of the app.
  ///
  /// Returns [Future] of [bool]
  Future<bool?> getIntroductionStatus() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(PrefsKeys.introduction.value);
  }
}
