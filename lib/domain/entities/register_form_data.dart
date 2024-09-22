/// RegisterFormData is a class that holds the data that is needed to register a user.
///
/// [username] is the username of the user.
/// [phoneNumber] is the phone number of the user.
/// [password] is the password of the user.
/// [confirmPassword] is the confirmation password of the user.
class RegisterFormData {
  /// The username of the user.
  String username;

  /// The phone number of the user.
  String phoneNumber;

  /// The password of the user.
  String password;

  /// The confirmation password of the user.
  String confirmPassword;

  RegisterFormData({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });
}
