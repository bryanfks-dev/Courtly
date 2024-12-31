import 'package:courtly/data/dto/court_dto.dart';

/// [BookingDTO] is a data transfer object that represents a booking.
class BookingDTO {
  /// [id] is the unique identifier of the booking.
  final int id;

  /// [court] is the court of the booking.
  final CourtDTO court;

  /// [startTime] is the start time of the booking.
  final String startTime;

  /// [endTime] is the end time of the booking.
  final String endTime;

  BookingDTO({
    required this.id,
    required this.court,
    required this.startTime,
    required this.endTime,
  });

  /// [fromJson] is a factory method that creates a [BookingDTO] instance from a JSON object.
  ///
  /// Parameters:
  ///   - [json] is a JSON object.
  ///
  /// Returns a [BookingDTO] instance.
  factory BookingDTO.fromJson(Map<String, dynamic> json) {
    return BookingDTO(
      id: json['id'],
      court: CourtDTO.fromJson(json['court']),
      startTime: json['book_start_time'],
      endTime: json['book_end_time'],
    );
  }
}
