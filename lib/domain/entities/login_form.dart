/// [LoginForm] is a class that holds the data that is needed to login a user.
///
/// [LoginForm] takes [username] and [password] as required data, [username]
/// is the username of the user and [password] is the password of the user.
class LoginForm {
  /// [username] is the username of the user.
  final String username;

  /// [password] is the password of the user.
  final String password;

  LoginForm({
    required this.username,
    required this.password,
  });
}
