import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/data/dto/bookings_response_dto.dart';
import 'package:courtly/data/dto/court_dto.dart';
import 'package:courtly/data/dto/courts_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [CourtRepository] is a class that handles the court related operations.
class CourtRepository {
  /// [_apiRepository] is the repository to handle API requests.
  final ApiRepository _apiRepository = ApiRepository();

  /// [_tokenRepository] is the repository to handle request token.
  final TokenRepository _tokenRepository = TokenRepository();

  /// [getCourts] is a function that fetches the courts from the API.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [Either] [Failure] and a [List] of [CourtDTO].
  Future<Either<Failure, List<CourtDTO>>> getCourts(
      {String? courtType, String? vendorName}) async {
    /// [queryParams] is the query parameters for the API request
    final Map<String, String> queryParams = {};

    // Check if the court type is not null
    if (courtType != null) {
      queryParams["type"] = courtType;
    }

    // Check if the vendor name is not null and not empty
    if (vendorName != null && vendorName.isNotEmpty) {
      queryParams["search"] = vendorName;
    }

    // Fetch the courts from the API.
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "courts", queryParam: queryParams, timeoutInSec: 10);

    // Check if the response is a success.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response
    final ResponseDTO<CourtsResponseDTO> courtsResponse = ResponseDTO.fromJson(
        json: jsonDecode(response.body), fromJsonT: CourtsResponseDTO.fromJson);

    // Check if the response is a success.
    if (courtsResponse.success) {
      return Right(courtsResponse.data!.courts);
    }

    // Check for different status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(courtsResponse.message));
    }

    return Left(UnknownFailure(courtsResponse.message));
  }

  /// [getVendorCourtsUsingCourtType] is a function that fetches the courts from the API.
  ///
  /// Parameters:
  ///   - [vendorId] is the ID of the vendor.
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [Either] [Failure] and a [List] of [CourtDTO].
  Future<Either<Failure, List<CourtDTO>>> getVendorCourtsUsingCourtType(
      {required vendorId, required String courtType}) async {
    // Set request token
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Fetch the courts from the API.
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "vendors/$vendorId/courts/$courtType", timeoutInSec: 5);

    // Check if the response is a success.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response
    final ResponseDTO<CourtsResponseDTO> courtsResponse = ResponseDTO.fromJson(
        json: jsonDecode(response.body), fromJsonT: CourtsResponseDTO.fromJson);

    // Check if the response is a success.
    if (courtsResponse.success) {
      return Right(courtsResponse.data!.courts);
    }

    // Check for different status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(courtsResponse.message));
    }

    return Left(UnknownFailure(courtsResponse.message));
  }

  /// [getCourtBookings] is a function that fetched court bookings from the API.
  ///
  /// Parameters:
  ///   - [vendorId] is the ID of the vendor.
  ///   - [courtType] is the type of the court.
  ///   - [date] is the date of the booking.
  ///
  /// Returns a [Future] of [Either] a [Failure] or a [List] of [BookingDTO]
  Future<Either<Failure, List<BookingDTO>>> getCourtBookings(
      {required int vendorId,
      required String courtType,
      required String date}) async {
    // Set request token
    await _apiRepository.setTokenFromStorage(tokenRepository: _tokenRepository);

    // Initialize query paramters map
    final Map<String, dynamic> queryParams = {"date": date};

    // Send request to the server
    final Either<Failure, http.Response> res = await _apiRepository.get(
        endpoint: "vendors/$vendorId/courts/$courtType/bookings",
        queryParam: queryParams,
        timeoutInSec: 5);

    // Check if the response is a success.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response
    final ResponseDTO<BookingsResponseDTO> bookingsResponse =
        ResponseDTO.fromJson(
            json: jsonDecode(response.body),
            fromJsonT: BookingsResponseDTO.fromJson);

    // Check if response is success
    if (bookingsResponse.success) {
      return right(bookingsResponse.data!.bookings);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.badRequest) {
      return left(RequestFailure(bookingsResponse.message));
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      return left(ServerFailure(bookingsResponse.message));
    }

    return left(UnknownFailure(bookingsResponse.message));
  }
}
