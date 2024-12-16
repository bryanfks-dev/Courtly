import 'package:courtly/data/dto/booking_dto.dart';

/// [BookingsResponseDTO] is the data transfer object for bookings response.
class BookingsResponseDTO {
  /// [bookings] is the list of bookings.
  final List<BookingDTO> bookings;

  BookingsResponseDTO({required this.bookings});

  /// [fromJson] is the factory method to create a [BookingsResponseDTO] from a map.
  ///
  /// Paramters:
  ///   - [json] is the map to create a [BookingsResponseDTO] from.
  ///
  /// Returns [BookingsResponseDTO]
  factory BookingsResponseDTO.fromJson(Map<String, dynamic> json) {
    return BookingsResponseDTO(
      bookings: (json['bookings'] as List<dynamic>)
          .map((x) => BookingDTO.fromJson(x))
          .toList(),
    );
  }
}
