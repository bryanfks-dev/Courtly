import 'package:courtly/data/dto/user_dto.dart';

/// [RegisterResponseDTO] is the data transfer object for register response.
class RegisterResponseDTO {
  /// [user] is the user.
  final UserDTO user;

  RegisterResponseDTO({required this.user});

  /// [fromJson] is a function to convert a map to a [RegisterResponseDTO].
  factory RegisterResponseDTO.fromJson(Map<String, dynamic> json) {
    return RegisterResponseDTO(
      user: UserDTO.fromJson(json['user']),
    );
  }
}