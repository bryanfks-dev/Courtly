/// [LoginFormDTO] is a class that holds the data that is needed to login a user.
///
/// [LoginFormDTO] takes [username] and [password] as required data, [username]
/// is the username of the user and [password] is the password of the user.
class LoginFormDTO {
  /// [username] is the username of the user.
  final String username;

  /// [password] is the password of the user.
  final String password;

  LoginFormDTO({
    required this.username,
    required this.password,
  });

  /// [toMap] is a method to convert the [LoginFormDTO] to a map.
  ///
  /// Returns a map of [String] key and [String] value.
  Map<String, String> toMap() {
    return {
      "username": username,
      "password": password,
    };
  }
}
