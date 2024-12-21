/// [ChangeUsernameFormDTO] is a data transfer object for the change username form.
class ChangeUsernameFormDTO {
  /// [newUsername] is the new username that the user wants to change to.
  final String newUsername;

  ChangeUsernameFormDTO({required this.newUsername});

  /// [toJson] is a method to convert the object to JSON.
  ///
  /// Returns [Map<String, dynamic>]
  Map<String, dynamic> toJson() {
    return {
      'new_username': newUsername,
    };
  }
}
