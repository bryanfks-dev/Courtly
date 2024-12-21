import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/dto/user_dto.dart';
import 'package:courtly/data/dto/user_response_dto.dart';
import 'package:courtly/data/dto/verify_password_form_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [VerifyPasswordRepository] is a repository class that handles the verification of the user's password.
class VerifyPasswordRepository {
  /// [_apiRepository] is an instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is an instance of [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [postPassword] is a method that sends the user's password to the server for verification.
  ///
  /// Parameters:
  ///   - [formDto] is an instance of [VerifyPasswordFormDTO].
  ///
  /// Returns a [Future] of [Either] a [Failure] or [UserDTO].
  Future<Either<Failure, UserDTO>> postPassword(
      {required VerifyPasswordFormDTO formDto}) async {
    // Set the token from storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Send the request to the server
    final Either<Failure, http.Response> res = await _apiRepository.patch(
        endpoint: 'auth/user/verify-password',
        body: formDto.toJson(),
        timeoutInSec: 1);

    // Check if the request is successful
    if (res.isLeft()) {
      return left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response response =
        res.getOrElse(() => throw UnknownFailure("Unknown error"));

    // Parse the response
    final ResponseDTO<UserResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(response.body), fromJsonT: UserResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return right(responseDto.data!.user);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.badRequest) {
      return left(FormFailure(responseDto.message));
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(responseDto.message));
    }

    return left(UnknownFailure(responseDto.message));
  }
}
