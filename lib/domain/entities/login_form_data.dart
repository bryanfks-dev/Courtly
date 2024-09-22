/// [LoginFormData] is a class that holds the data that is needed to login a user.
///
/// [LoginFormData] takes [username] and [password] as required data, [username]
/// is the username of the user and [password] is the password of the user.
class LoginFormData {
  /// [username] is the username of the user.
  final String username;

  /// [password] is the password of the user.
  final String password;

  LoginFormData({
    required this.username,
    required this.password,
  });
}
