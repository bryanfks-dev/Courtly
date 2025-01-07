import 'package:courtly/core/config/api_server_config.dart';
import 'package:courtly/data/dto/user_dto.dart';

/// [User] is an entity class that represents a user in the application
class User {
  /// [id] is a unique identifier for the user
  final int id;

  /// [username] is the username of the user
  final String username;

  /// [phoneNumber] is the phone number of the user
  final String? phoneNumber;

  /// [profilePictureUrl] is the URL of the user's profile picture
  final String profilePictureUrl;

  User(
      {required this.id,
      required this.username,
      required this.phoneNumber,
      required this.profilePictureUrl});

  /// [fromDTO] is a factory method that creates a [User] object from a [UserDTO] object
  ///
  /// Parameters:
  ///   - [dto] a [UserDTO] object
  ///
  /// Returns a [User] object
  factory User.fromDTO(UserDTO dto) {
    return User(
        id: dto.id,
        username: dto.username,
        phoneNumber: dto.phoneNumber,
        profilePictureUrl:
            (dto.profilePictureUrl != null || dto.profilePictureUrl!.isNotEmpty)
                ? "${ApiServerConfig.baseUrl}/${dto.profilePictureUrl}"
                : "");
  }
}
