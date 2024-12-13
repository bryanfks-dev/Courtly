import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/register_form_dto.dart';
import 'package:courtly/data/dto/register_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [RegisterRepository] is the repository for register.
/// This repository will handle the register process.
class RegisterRepository {
  /// [_apiRepository] is the repository for API.
  final ApiRepository _apiRepository = ApiRepository();

  /// [postRegister] is a function to handle the register process.
  ///
  /// Parameters:
  ///   - [formDto] is the register form data.
  ///
  /// Returns a [Either] of a [Failure] or [RegisterResponseDTO] object.
  Future<Either<Failure, RegisterResponseDTO>> postRegister(
      {required RegisterFormDTO formDto}) async {
    // Make a POST request to the API.
    final Either<Failure, http.Response> either = await _apiRepository.post(
        endpoint: 'auth/user/register', body: formDto.toMap(), timeoutInSec: 5);

    // Check for failure
    if (either.isLeft()) {
      return left(
          either.fold((l) => l, (r) => const UnknownFailure('Unknown error')));
    }

    // Get the response
    final http.Response res = either.getOrElse(() => throw 'No response');

    // Parse the response
    ResponseDTO<RegisterResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: RegisterResponseDTO.fromJson);

    // Check if the response is successful
    if (responseDto.success) {
      return right(responseDto.data!);
    }

    // Check for status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(responseDto.message));
    }

    if (res.statusCode == HttpStatus.forbidden) {
      return left(FormFailure(responseDto.message));
    }

    return left(UnknownFailure(responseDto.message));
  }
}
