import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/dto/reviews_response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [ReviewRepository] is a repository to handle review data.
class ReviewRepository {
  /// [_apiRepository] is the instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the instance of [TokenRepository].
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getReviews] is a function to get reviews from api.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [courtType] is the type of the court.
  ///   - [rating] is the rating of the review.
  ///
  /// Returns a [Future] [Either] a [Failure] or [ReviewsResponseDTO].
  Future<Either<Failure, ReviewsResponseDTO>> getReviews(
      {required int vendorId, required String courtType, int? rating}) async {
    // Set token from storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    /// [queryParams] is the query parameters for the API request
    final Map<String, String> queryParams = {};

    // Check if the rating is not null or 0
    if (rating != null && rating != 0) {
      queryParams["rating"] = rating.toString();
    }

    // Get reviews from the API.
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "vendors/$vendorId/courts/$courtType/reviews",
        queryParam: queryParams,
        timeoutInSec: 5);

    // Check if the response is successful.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unkown Error")));
    }

    // Parse the response.
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response
    final ResponseDTO<ReviewsResponseDTO> dto = ResponseDTO.fromJson(
        json: jsonDecode(response.body),
        fromJsonT: ReviewsResponseDTO.fromJson);

    // Check if the response is successful.
    if (dto.success) {
      return Right(dto.data!);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.badRequest) {
      return Left(RequestFailure(dto.message));
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(dto.message));
    }

    return Left(UnknownFailure("Unkown Error"));
  }
}
