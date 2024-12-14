import 'package:courtly/data/dto/user_dto.dart';

/// [LoginResponse] class is a data transfer object class
class LoginResponse {
  /// [user] is an instance of [UserDTO] class
  final UserDTO user;

  /// [token] is a string that holds the token value
  final String token;

  LoginResponse({required this.token, required this.user});

  /// [fromJson] is a factory method that returns an instance 
  /// of [LoginResponse] class
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserDTO.fromJson(json['user']),
      token: json['token'],
    );
  }
}
