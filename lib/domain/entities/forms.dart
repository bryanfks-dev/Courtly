/// LoginFormData is a class that holds the data that is needed to login a user.
///
/// [username] is the username of the user.
/// [password] is the password of the user.
class LoginFormData {
  /// The username of the user.
  final String username;

  /// The password of the user.
  final String password;

  LoginFormData({
    required this.username,
    required this.password,
  });
}

/// RegisterFormData is a class that holds the data that is needed to register a user.
///
/// [username] is the username of the user.
/// [password] is the password of the user.
/// [confirmPassword] is the confirmation password of the user.
/// [phoneNumber] is the phone number of the user.
class RegisterFormData {
  /// The username of the user.
  String username;

  /// The password of the user.
  String password;

  /// The confirmation password of the user.
  String confirmPassword;

  /// The phone number of the user.
  String phoneNumber;

  RegisterFormData({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });
}
