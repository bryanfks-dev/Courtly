/// [RegisterDTO] is a class that holds the data that is needed to register a user.
///
/// [RegisterDTO] holds the [username], [phoneNumber], [password],
/// and [confirmPassword] of the user to register the user.
class RegisterDTO {
  /// [username] is the username of the user.
  String username;

  /// [phoneNumber] is the phone number of the user.
  String phoneNumber;

  /// [password] is the password of the user.
  String password;

  /// [confirmPassword] is the confirmation password of the user.
  String confirmPassword;

  RegisterDTO({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });

  /// [toMap] is a method to convert the [RegisterDTO] to a map.
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
