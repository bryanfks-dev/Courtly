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
  Future<Either<Failure, List<Court>>> getCourts({String? courtType}) async {
    // Fetch courts from the repository.
    final Either<Failure, List<CourtDTO>> res =
        await courtRepository.getCourts(courtType: courtType);

    return res.fold((l) => Left(l), (r) {
      // Convert the list of [CourtDTO] to a list of [Court].
      final List<Court> courts = r.map((e) => Court.fromDTO(e)).toList();

      return Right(courts);
    });
  }
}
