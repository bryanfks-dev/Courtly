import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/data/dto/court_dto.dart';
import 'package:courtly/data/repository/api/court_repository.dart';
import 'package:courtly/domain/entities/booking.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

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

  /// [getCourtBookings] is a method that fetches the bookings for a court.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [courtType] is the type of the court.
  ///   - [date] is the date of the booking.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [List] of [Booking]
  Future<Either<Failure, List<Booking>>> getCourtBookings(
      {required int vendorId,
      required String courtType,
      required DateTime date}) async {
    // Create a date formatter
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    // Fetch bookings from the repository.
    final Either<Failure, List<BookingDTO>> res =
        await courtRepository.getCourtBookings(
            vendorId: vendorId,
            courtType: courtType,
            date: formatter.format(date));

    // Convert the list of [BookingDTO] to a list of [Booking].
    return res.fold((l) => Left(l),
        (r) => Right(r.map((e) => Booking.fromDTO(e)).toList()));
  }
}
