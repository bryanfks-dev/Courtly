/// [LoginDTO] is a class that holds the data that is needed to login a user.
///
/// [LoginDTO] takes [username] and [password] as required data, [username]
/// is the username of the user and [password] is the password of the user.
class LoginDTO {
  /// [username] is the username of the user.
  final String username;

  /// [password] is the password of the user.
  final String password;

  LoginDTO({
    required this.username,
    required this.password,
  });

  /// [toMap] is a method to convert the [LoginDTO] to a map.
  ///
  /// Returns a map of [String] key and [String] value.
  Map<String, String> toMap() {
    return {
      "username": username,
      "password": password,
    };
  }
}
