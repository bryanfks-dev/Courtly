import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/data/dto/bookings_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [BookingRepository] is a class that handles the booking related operations.
class BookingRepository {
  /// [_apiRepository] is the API repository.
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the token repository.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getBookings] is the function to get the bookings.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [List] of [BookingDTO].
  Future<Either<Failure, List<BookingDTO>>> getBookings(
      {String? courtType}) async {
    /// [queryParams] is the query parameters for the API request.
    final Map<String, String> queryParams = {};

    // Check if the court type is not null.
    if (courtType != null) {
      queryParams["courtType"] = courtType;
    }

    // Set the token from storage.
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Get the bookings.
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "users/me/bookings",
        queryParam: queryParams,
        timeoutInSec: 5);

    // Check if the request fails.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response.
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response.
    final ResponseDTO<BookingsResponseDTO> bookings = ResponseDTO.fromJson(
        json: jsonDecode(response.body),
        fromJsonT: BookingsResponseDTO.fromJson);

    // Check if the response is a success.
    if (bookings.success) {
      return Right(bookings.data!.bookings);
    }

    // Check for different status codes.
    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(UnknownFailure("Internal Server Error"));
    }

    return Left(UnknownFailure(bookings.message));
  }
}
