import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:intl/intl.dart';

class Booking {
  /// [id] is the unique identifier for the booking.
  final int id;

  /// [court] is the court for the booking.
  final Court court;

  /// [startTime] is the start time of the booking.
  final DateTime startTime;

  /// [endTime] is the end time of the booking.
  final DateTime endTime;

  Booking({
    required this.id,
    required this.court,
    required this.startTime,
    required this.endTime,
  });

  /// [fromDTO] is a factory method that creates a [Booking] instance from a
  /// [BookingDTO] instance.
  ///
  /// Parameters:
  ///   - [dto] is a [BookingDTO] instance.
  ///
  /// Returns a [Booking] instance.
  factory Booking.fromDTO(BookingDTO dto) {
    /// [timeFormatter] is a date formatter for time.
    final DateFormat timeFormatter = DateFormat("HH:mm");

    return Booking(
      id: dto.id,
      court: Court.fromDTO(dto.court),
      startTime: timeFormatter.parse(dto.startTime),
      endTime: timeFormatter.parse(dto.endTime),
    );
  }
}
