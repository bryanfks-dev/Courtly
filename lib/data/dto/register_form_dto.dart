/// [RegisterFormDTO] is a class that holds the data that is needed to register a user.
///
/// [RegisterFormDTO] holds the [username], [phoneNumber], [password],
/// and [confirmPassword] of the user to register the user.
class RegisterFormDTO {
  /// [username] is the username of the user.
  String username;

  /// [phoneNumber] is the phone number of the user.
  String phoneNumber;

  /// [password] is the password of the user.
  String password;

  /// [confirmPassword] is the confirmation password of the user.
  String confirmPassword;

  RegisterFormDTO({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });

  /// [toMap] is a method to convert the [RegisterFormDTO] to a map.
  ///
  /// Returns a map of [String] key and [String] value.
  Map<String, String> toMap() {
    return {
      "username": username,
      "phone_number": phoneNumber,
      "password": password,
      "confirm_password": confirmPassword,
    };
  }
}
