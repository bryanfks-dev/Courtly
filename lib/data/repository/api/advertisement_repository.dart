import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/advertisement_dto.dart';
import 'package:courtly/data/dto/advertisement_response_dto.dart';
import 'package:courtly/data/dto/response_dto.dart';
import 'package:courtly/data/repository/api/api_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AdvertisementRepository {
  /// [_apiRepository] is the instance of [ApiRepository].
  final ApiRepository _apiRepository = ApiRepository();

  /// [getAdvertisements] is a method that fetches advertisements from the API.
  ///
  /// Returns [Future] of [Either] a [Failure] or [List] of [AdvertisementDTO].
  Future<Either<Failure, List<AdvertisementDTO>>> getAdvertisements() async {
    // Get advertisements from the API.
    final Either<Failure, http.Response> res =
        await _apiRepository.get(endpoint: "advertisements", timeoutInSec: 2);

    // Check if the response is a success.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final http.Response response = res.getOrElse(() => throw "No Response");

    // Parse the response
    final ResponseDTO<AdvertisementResponseDTO> responseDto =
        ResponseDTO.fromJson(
            json: jsonDecode(response.body),
            fromJsonT: AdvertisementResponseDTO.fromJson);

    // Check if the response is a success.
    if (responseDto.success) {
      return Right(responseDto.data!.ads);
    }

    // Check for status codes
    if (response.statusCode == HttpStatus.internalServerError) {
      return Left(ServerFailure(responseDto.message));
    }

    return Left(UnknownFailure("Unknown error"));
  }
}
