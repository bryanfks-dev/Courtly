import 'dart:convert';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/fees_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [FeesRepository] is a repository for fees.
class FeesRepository {
  /// [_apiRepository] is an instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is an instance of [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getFees] is a function to get the fees.
  ///
  /// Returns a [Future] of [Either] [Failure] and [FeesResponseDTO].
  Future<Either<Failure, FeesResponseDTO>> getFees() async {
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Fetch the fees from the API.
    final Either<Failure, http.Response> res =
        await _apiRepository.get(endpoint: "fees", timeoutInSec: 1);

    // Check if the response is a success.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response
    final ResponseDTO<FeesResponseDTO> responseDto = ResponseDTO.fromJson(
        json: jsonDecode(response.body), fromJsonT: FeesResponseDTO.fromJson);

    // Check if the response is a success.
    if (responseDto.success) {
      return Right(responseDto.data!);
    }

    return Left(UnknownFailure("Unknown error"));
  }
}
