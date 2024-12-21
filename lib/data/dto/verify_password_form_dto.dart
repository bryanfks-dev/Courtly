/// [VerifyPasswordFormDTO] is a data transfer object class for the password verification form data.
class VerifyPasswordFormDTO {
  /// [password] is the password of the user
  final String password;

  VerifyPasswordFormDTO({required this.password});

  /// [toJson] is the function to convert the object to a map
  ///
  /// Returns [Map] of [String] and [String]
  Map<String, String> toJson() {
    return {
      'password': password,
    };
  }
}
