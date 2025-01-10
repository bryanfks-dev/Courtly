import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/change_password_form_dto.dart';
import 'package:courtly/data/dto/change_profile_picture_dto.dart';
import 'package:courtly/data/dto/change_username_form_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/dto/user_dto.dart';
import 'package:courtly/data/dto/user_response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/local/token_repository.dart';
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

  /// [patchUsername] is a function to patch the username.
  ///
  /// Parameters:
  ///   - [formDto] is the form data transfer object.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> patchUsername(
      {required ChangeUsernameFormDTO formDto}) async {
    // Set token from storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Patch username
    final Either<Failure, http.Response> res = await _apiRepository.patch(
        endpoint: 'users/me/username', body: formDto.toJson(), timeoutInSec: 2);

    // Check if response is left
    if (res.isLeft()) {
      return res.fold((l) => l, (r) => UnknownFailure("Unknown error"));
    }

    // Parse response to http response
    final http.Response response = res.getOrElse(() => throw 'No response');

    // Parse response
    final ResponseDTO responseDto =
        ResponseDTO.fromJson(json: jsonDecode(response.body));

    // Check if response is successful
    if (responseDto.success) {
      return null;
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.badRequest) {
      return FormFailure(responseDto.message);
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }

  /// [patchPassword] is a function to patch the password.
  ///
  /// Parameters:
  ///   - [formDto] is the form data transfer object.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> patchPassword(
      {required ChangePasswordFormDTO formDto}) async {
    // Set token from storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Patch password
    final Either<Failure, http.Response> res = await _apiRepository.patch(
        endpoint: 'users/me/password', body: formDto.toJson(), timeoutInSec: 5);

    // Check if response is left
    if (res.isLeft()) {
      return res.fold((l) => l, (r) => UnknownFailure("Unknown error"));
    }

    // Parse response to http response
    final http.Response response = res.getOrElse(() => throw 'No response');

    // Parse response
    final ResponseDTO responseDto =
        ResponseDTO.fromJson(json: jsonDecode(response.body));

    // Check if response is successful
    if (responseDto.success) {
      return null;
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.badRequest) {
      return FormFailure(responseDto.message);
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }

  /// [patchProfilePicture] is a function to patch the profile picture.
  /// 
  /// Parameters:
  ///   - [dto] is the data transfer object.
  /// 
  /// Returns [Future] of [Failure].
  Future<Failure?> patchProfilePicture({
    required ChangeProfilePictureDTO dto,
  }) async {
    // Set token from storage
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Patch password
    final Either<Failure, http.Response> res = await _apiRepository.patch(
        endpoint: 'users/me/profile-picture', body: dto.toJson(), timeoutInSec: 5);

    // Check if response is left
    if (res.isLeft()) {
      return res.fold((l) => l, (r) => UnknownFailure("Unknown error"));
    }

    // Parse response to http response
    final http.Response response = res.getOrElse(() => throw 'No response');

    // Parse response
    final ResponseDTO responseDto =
        ResponseDTO.fromJson(json: jsonDecode(response.body));

    // Check if response is successful
    if (responseDto.success) {
      return null;
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.badRequest) {
      return FormFailure(responseDto.message);
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDto.message);
    }

    return UnknownFailure(responseDto.message);
  }
}
