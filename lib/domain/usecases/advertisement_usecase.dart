import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/advertisement_dto.dart';
import 'package:courtly/data/repository/api/advertisement_repository.dart';
import 'package:courtly/domain/entities/advertisement.dart';
import 'package:dartz/dartz.dart';

/// [AdvertisementUsecase] is a usecase for advertisements.
class AdvertisementUsecase {
  /// [advertisementRepository] is an instance of [AdvertisementRepository].
  final AdvertisementRepository advertisementRepository;

  AdvertisementUsecase({required this.advertisementRepository});

  Future<Either<Failure, List<Advertisement>>> getAdvertisements() async {
    // Get advertisements from the repository.
    final Either<Failure, List<AdvertisementDTO>> res =
        await advertisementRepository.getAdvertisements();

    // Return the result.
    return res.fold(
      (l) => Left(l),
      (r) => Right(r.map((x) => Advertisement.fromDTO(x)).toList()),
    );
  }
}
