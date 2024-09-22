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
