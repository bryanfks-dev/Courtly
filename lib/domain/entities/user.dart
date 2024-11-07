/// [User] is an entity class that represents a user in the application
class User {
  /// [id] is a unique identifier for the user
  final String id;

  /// [name] is the name of the user
  final String name;

  /// [phoneNumber] is the phone number of the user
  final String phoneNumber;

  /// [profilePictureUrl] is the URL of the user's profile picture
  final String profilePictureUrl;

  User(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      this.profilePictureUrl = ''});

  /// [User.fromJson] method to convert a map to a [User] instance
  /// This method is a factory method that returns a new instance of [User]
  factory User.fromJson(Map<String, String> json) {
    return User(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        profilePictureUrl: json['profile_picture_url'] ?? '');
  }
}
