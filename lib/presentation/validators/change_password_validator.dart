import 'package:courtly/core/constants/constants.dart';

/// [ChangePasswordFormValidator] is a class that validates the change password form.
/// It checks if the old password, new password, and confirm password are valid or not.
class ChangePasswordFormValidator {
  /// [validateOldPassword] is a method that validates the old password.
  ///
  /// Parameters:
  ///   - [oldPassword]: The old password to validate.
  ///
  /// Returns a [String] message.
  String? validateOldPassword({required String oldPassword}) {
    // Check if the old password is empty.
    if (oldPassword.isEmpty) {
      return "Current password is required";
    }

    return null;
  }

  /// [validateNewPassword] is a method that validates the new password.
  ///
  /// Parameters:
  ///   - [newPassword]: The new password to validate.
  ///
  /// Returns a [String] message.
  String? validateNewPassword({required String newPassword}) {
    // Check if the new password is empty.
    if (newPassword.isEmpty) {
      return "New password is required";
    }

    // Check if the new password is less than the minimum password length.
    if (newPassword.length < MINIMUM_PASSWORD_LENGTH) {
      return "Password must be at least $MINIMUM_PASSWORD_LENGTH characters";
    }

    return null;
  }

  /// [validateConfirmPassword] is a method that validates the confirm password.
  ///
  /// Parameters:
  ///   - [confirmPassword]: The confirm password to validate.
  ///
  /// Returns a [String] message.
  String? validateConfirmPassword(
      {required String confirmPassword, required String newPassword}) {
    // Check if the confirm password is empty.
    if (confirmPassword.isEmpty) {
      return "Confirm password is required";
    }

    // Check if the confirm password is not equal to the new password.
    if (confirmPassword != newPassword) {
      return "Passwords do not match";
    }

    return null;
  }
}
