import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/dto/user_dto.dart';
import 'package:courtly/data/dto/user_response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [UserRepository] is the repository for user data.
class UserRepository {
  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the token repository.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getCurrentUser] is a function to get the current user data.
  ///
  /// Returns [Future] of [Either] a [Failure] or [UserDTO].
  Future<Either<Failure, UserDTO>> getCurrentUser() async {
    // Set token from storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Get user data
    final Either<Failure, http.Response> res =
        await _apiRepository.get(endpoint: 'users/me', timeoutInSec: 3);

    // Check if response is left
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Parse response to http response
    final http.Response response = res.getOrElse(() => throw 'No response');

    // Parse response to UserDTO
    final ResponseDTO<UserResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(response.body), fromJsonT: UserResponseDTO.fromJson);

    // Check if response is successful
    if (responseDto.success) {
      return Right(responseDto.data!.user);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message));
    }

    return Left(UnknownFailure(responseDto.message));
  }
}
