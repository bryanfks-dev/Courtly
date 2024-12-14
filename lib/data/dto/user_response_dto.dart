import 'package:courtly/data/dto/user_dto.dart';

/// [UserResponseDTO] is the response DTO for user data.
class UserResponseDTO {
  /// [user] is the user data.
  final UserDTO user;

  UserResponseDTO({required this.user});

  /// [fromJson] is a factory method to create a [UserResponseDTO] from a JSON object.
  ///
  /// Parameters:
  ///   - [json] is the JSON object.
  ///
  /// Returns a [UserResponseDTO]
  factory UserResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserResponseDTO(user: UserDTO.fromJson(json['user']));
  }
}
