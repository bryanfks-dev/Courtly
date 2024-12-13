import 'package:courtly/core/constants/constants.dart';

/// [RegisterFormValidator] is a class to validate register form.
/// This class is used to validate register form.
class RegisterFormValidator {
  /// [validateUsername] is a function to validate username.
  ///
  /// Parameters:
  ///   - [username] is the username to validate.
  ///
  /// Returns [String] if username is invalid.
  String? validateUsername({required String username}) {
    // Check if username is empty
    if (username.trim().isEmpty) {
      return "Username is required";
    }

    // Check username length
    if (username.trim().length < MINIMUM_USERNAME_LENGTH) {
      return "Username must be at least $MINIMUM_USERNAME_LENGTH characters";
    }

    return null;
  }

  /// [validatePhoneNumber] is a function to validate phone number.
  ///
  /// Parameters:
  ///   - [phoneNumber] is the phone number to validate.
  ///
  /// Returns [String] if phone number is invalid.
  String? validatePhoneNumber({required String phoneNumber}) {
    // Check if phone number is empty
    if (phoneNumber.trim().isEmpty) {
      return "Phone number is required";
    }

    // Check if phone number length is valid
    if (phoneNumber.trim().length < 11) {
      return "Phone number is invalid";
    }

    // Check if phone number is valid
    if (!RegExp(r'^8[0-9]{10,12}$').hasMatch(phoneNumber.trim())) {
      return "Phone number is invalid";
    }

    return null;
  }

  /// [validatePassword] is a function to validate password.
  ///
  /// Parameters:
  ///   - [password] is the password to validate.
  ///
  /// Returns [String] if password is invalid.
  String? validatePassword({required String password}) {
    // Check if password is empty
    if (password.trim().isEmpty) {
      return "Password is required";
    }

    // Check password length
    if (password.trim().length < MINIMUM_PASSWORD_LENGTH) {
      return "Password must be at least $MINIMUM_PASSWORD_LENGTH characters";
    }

    return null;
  }

  /// [validateConfirmPassword] is a function to validate confirm password.
  ///
  /// Parameters:
  ///   - [password] is the password to compare.
  ///   - [confirmPassword] is the confirm password to validate.
  ///
  /// Returns [String] if confirm password is invalid.
  String? validateConfirmPassword(
      {required String password, required String confirmPassword}) {
    // Check if confirm password is empty
    if (confirmPassword.trim().isEmpty) {
      return "Confirm password is required";
    }

    // Check if confirm password is the same as password
    if (confirmPassword.trim() != password.trim()) {
      return "Password does not match";
    }

    return null;
  }
}
