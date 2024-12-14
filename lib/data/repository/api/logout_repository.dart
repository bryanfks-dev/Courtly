import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [LogoutRepository] is a class that handles the logging out of the user.
class LogoutRepository {
  /// [_apiRepository] is the instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the instance of [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [logout] is the function that logs the user out.
  ///
  /// Returns [Future] of [Failure]
  Future<Failure?> logout() async {
    // Set the token to api repository
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Make a post request to the logout endpoint
    final Either<Failure, http.Response> res = await _apiRepository.post(
        endpoint: "auth/user/logout", timeoutInSec: 5);

    // Check for failure
    if (res.isLeft()) {
      return res.fold((l) => l, (r) => null);
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw Exception());

    // Parse the response body
    final ResponseDTO responseDTO =
        ResponseDTO.fromJson(json: jsonDecode(response.body));

    // Check if the response is successful
    if (responseDTO.success) {
      return null;
    }

    // Check status code
    if (response.statusCode == HttpStatus.internalServerError) {
      return ServerFailure(responseDTO.message);
    }

    return UnknownFailure(responseDTO.message);
  }
}
