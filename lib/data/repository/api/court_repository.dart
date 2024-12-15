import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/court_dto.dart';
import 'package:courtly/data/dto/courts_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

/// [CourtRepository] is a class that handles the court related operations.
class CourtRepository {
  /// [_apiRepository] is the repository to handle API requests.
  final ApiRepository _apiRepository = ApiRepository();

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
      queryParams["courtType"] = courtType;
    }

    // Check if the vendor name is not null and not empty
    if (vendorName != null && vendorName.isNotEmpty) {
      queryParams["vendorName"] = vendorName;
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
}
