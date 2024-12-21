import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/create_bookings_dto.dart';
import 'package:courtly/data/repository/api/booking_repository.dart';
import 'package:courtly/domain/props/booking_value_props.dart';

/// [BookingUsecase] is a usecase for booking.
class BookingUsecase {
  /// [bookingRepository] is the repository for booking.
  final BookingRepository bookingRepository;

  BookingUsecase({required this.bookingRepository});

  /// [createBookings] is a method to create bookings.
  ///
  /// Parameters:
  ///   - [dto] is a [CreateBookingsDTO] object.
  ///
  /// Returns a [Future] of [Failure]
  Future<Failure?> createBookings(
      {required int vendorId,
      required String date,
      required Set<BookingValueProps> bookingDatas}) async {
    /// [bookingDatasGroup] is a list of groupped booking data based on
    /// court id.
    final Map<int, List<BookingValueProps>> bookingDatasGroupped = {};

    // Group booking data by court id by looping through the booking data
    for (final bookingData in bookingDatas) {
      // Check if the court id is already in the list
      if (bookingDatasGroupped.containsKey(bookingData.courtId)) {
        bookingDatasGroupped[bookingData.courtId]!.add(bookingData);

        continue;
      }

      bookingDatasGroupped[bookingData.courtId] = [bookingData];
    }

    // Create DTO from props
    final CreateBookingsDTO dto = CreateBookingsDTO(
        date: date,
        vendorId: vendorId,
        bookings: bookingDatasGroupped
            .map((k, v) => MapEntry(
                k,
                CreateBookingsInnerDTO(
                    courtId: k, bookTimes: v.map((e) => e.time).toList())))
            .values
            .toList());

    // Create bookings from repository
    final Failure? res = await bookingRepository.createBookings(dto: dto);

    return res;
  }
}
