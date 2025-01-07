import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/fees_response_dto.dart';
import 'package:courtly/data/repository/api/fees_repository.dart';
import 'package:courtly/domain/entities/fees.dart';
import 'package:dartz/dartz.dart';

/// [FeesUsecase] is a class that handles the fees related operations.
class FeesUsecase {
  /// [feesRepository] is the repository to handle fees related operations.
  final FeesRepository feesRepository;

  FeesUsecase({required this.feesRepository});

  /// [getFees] is a function that fetches the fees from the repository.
  ///
  /// Returns a [Future] of [Either] [Failure] and [Fees].
  Future<Either<Failure, Fees>> getFees() async {
    // Fetch the fees from the repository.
    final Either<Failure, FeesResponseDTO> res = await feesRepository.getFees();

    // Check if the response is a success.
    if (res.isLeft()) {
      return Left(res.fold((l) => l, (r) => UnknownFailure("Unknown error")));
    }

    // Get the response
    final FeesResponseDTO feesResponse =
        res.getOrElse(() => throw "No Response");

    // Return the fees
    return Right(Fees(appFee: feesResponse.appFee));
  }
}
