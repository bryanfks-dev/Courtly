/// RegisterForm is a class that holds the data that is needed to register a user.
///
/// [RegisterForm] holds the [username], [phoneNumber], [password],
/// and [confirmPassword] of the user to register the user.
class RegisterForm {
  /// [username] is the username of the user.
  String username;

  /// [phoneNumber] is the phone number of the user.
  String phoneNumber;

  /// [password] is the password of the user.
  String password;

  /// [confirmPassword] is the confirmation password of the user.
  String confirmPassword;

  RegisterForm({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });
}
