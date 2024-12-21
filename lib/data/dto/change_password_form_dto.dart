/// [ChangePasswordFormDTO] is a data transfer object class for the change password form
class ChangePasswordFormDTO {
  /// [oldPassword] is the old password of the user
  final String oldPassword;

  /// [newPassword] is the new password of the user
  final String newPassword;

  /// [confirmPassword] is the confirmation of the new password of the user
  final String confirmPassword;

  ChangePasswordFormDTO({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  /// [toJson] is the function to convert the object to a map
  ///
  /// Returns [Map] of [String] and [String]
  Map<String, String> toJson() {
    return {
      "old_password": oldPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    };
  }
}
