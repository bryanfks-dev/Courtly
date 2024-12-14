/// [LoginFormValidator] is a class that contains all the validation
/// methods for the login form.
class LoginFormValidator {
  /// [validateUsername] is a method to validate the username.
  ///
  /// Parameters:
  ///   - [username] is the username to be validated.
  ///
  /// Returns [String] if the username is invalid.
  String? validateUsername({required String username}) {
    if (username.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  /// [validatePassword] is a method to validate the password.
  ///
  /// Parameters:
  ///   - [password] is the password to be validated.
  ///
  /// Returns [String] if the password is invalid.
  String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return "Password is required";
    }
    return null;
  }
}
