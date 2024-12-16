import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/data/repository/api/booking_repository.dart';
import 'package:courtly/domain/entities/booking.dart';
import 'package:dartz/dartz.dart';

/// [BookingUsecase] is a usecase for booking.
class BookingUsecase {
  /// [bookingRepository] is the repository for booking.
  final BookingRepository bookingRepository;

  BookingUsecase({required this.bookingRepository});

  /// [getBookings] is a method to get bookings.
  ///
  /// Returns [Either] a [Failure] or [List] of [Booking]
  Future<Either<Failure, List<Booking>>> getBookings() async {
    final Either<Failure, List<BookingDTO>> res =
        await bookingRepository.getBookings();

    return res.fold((l) => Left(l),
        (r) => Right(r.map((e) => Booking.fromDTO(e)).toList()));
  }
}
