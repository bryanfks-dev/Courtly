import 'package:courtly/core/constants/constants.dart';

/// [ChangeUsernameValidator] is a class that validates the change password form
class ChangeUsernameValidator {
  /// [validateUsername] is a method that validates the username.
  /// 
  /// Parameters:
  ///   - [username] is the username to be validated.
  /// 
  /// Returns [String] if the username is empty.
  String? validateUsername({required String username}) {
    // Check if username is empty
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }

    // Check if username is less than minimum length
    if (username.length < MINIMUM_USERNAME_LENGTH) {
      return 'Username must be at least $MINIMUM_PASSWORD_LENGTH characters';
    }

    return null;
  }
}
