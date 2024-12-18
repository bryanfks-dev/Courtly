import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/court_dto.dart';
import 'package:courtly/data/repository/api/court_repository.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:dartz/dartz.dart';

/// [CourtUsecase] is a class that handles the business logic for court related operations.
class CourtUsecase {
  /// [courtRepository] is the repository for court related operations.
  final CourtRepository courtRepository;

  CourtUsecase({required this.courtRepository});

  /// [getCourts] is a method that fetches the list of courts.
  ///
  /// Returns a [Future] of [Either] [Failure] and a list of [Court].
  Future<Either<Failure, List<Court>>> getCourts(
      {String? courtType, String? vendorName}) async {
    // Fetch courts from the repository.
    final Either<Failure, List<CourtDTO>> res = await courtRepository.getCourts(
        courtType: courtType, vendorName: vendorName);

    return res.fold((l) => Left(l), (r) {
      // Convert the list of [CourtDTO] to a list of [Court].
      final List<Court> courts = r.map((e) => Court.fromDTO(e)).toList();

      return Right(courts);
    });
  }

  /// [getVendorCourtsUsingCourtType] is a method that fetches the list of courts for a vendor using the court type.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [courtType] is the type of court.
  ///
  /// Returns a [Future] of [Either] [Failure] and a list of [Court].
  Future<Either<Failure, List<Court>>> getVendorCourtsUsingCourtType(
      {required int vendorId, required String courtType}) async {
    // Fetch courts from the repository.
    final Either<Failure, List<CourtDTO>> res =
        await courtRepository.getVendorCourtsUsingCourtType(
            vendorId: vendorId, courtType: courtType);

    // Convert the list of [CourtDTO] to a list of [Court].
    return res.fold(
        (l) => Left(l), (r) => Right(r.map((e) => Court.fromDTO(e)).toList()));
  }
}
