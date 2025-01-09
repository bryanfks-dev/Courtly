import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/login_form_dto.dart';
import 'package:courtly/data/dto/login_response.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [LoginRepository] class is a repository class that handles
/// the login data from the server
class LoginRepository {
  /// [_apiRepository] is an instance of [ApiRepository] class
  final ApiRepository _apiRepository = ApiRepository();

  /// [postLogin] method is used to post login data to the server
  ///
  /// Parameters:
  ///   - [formDto] is an instance of [LoginFormDTO] class
  ///
  /// Returns [Either] a [Failure] or [LoginResponse] object
  Future<Either<Failure, LoginResponse>> postLogin(
      {required LoginFormDTO formDto}) async {
    // Make a POST request to the API.
    final Either<Failure, http.Response> response = await _apiRepository.post(
      endpoint: "auth/user/login",
      body: formDto.toMap(),
      timeoutInSec: 5,
    );

    // Check for failure
    if (response.isLeft()) {
      return left(response.fold(
          (l) => l, (r) => const UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response res = response.getOrElse(() => throw "No response");

    // Parse the response
    final ResponseDTO<LoginResponse> loginResponse = ResponseDTO.fromJson(
        json: jsonDecode(res.body), fromJsonT: LoginResponse.fromJson);

    // Check if the response is successful
    if (loginResponse.success) {
      return right(loginResponse.data!);
    }

    // Check for different status codes
    if (res.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(loginResponse.message));
    }

    if (res.statusCode == HttpStatus.badRequest ||
        res.statusCode == HttpStatus.unauthorized) {
      return left(FormFailure(loginResponse.message));
    }

    return left(UnknownFailure(loginResponse.message));
  }
}
