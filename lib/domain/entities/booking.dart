import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/domain/entities/order.dart';
import 'package:intl/intl.dart';

class Booking {
  /// [id] is the unique identifier for the booking.
  final int id;

  /// [order] is the order for the booking.
  final Order order;

  /// [court] is the court for the booking.
  final Court court;

  /// [date] is the date of the booking.
  final DateTime date;

  /// [startTime] is the start time of the booking.
  final DateTime startTime;

  /// [endTime] is the end time of the booking.
  final DateTime endTime;

  Booking({
    required this.id,
    required this.order,
    required this.court,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory Booking.fromDTO(BookingDTO dto) {
    /// [dateFormatter] is a date formatter for date.
    final DateFormat dateFormatter = DateFormat("yyyy-MM-dd");

    /// [timeFormatter] is a date formatter for time.
    final DateFormat timeFormatter = DateFormat("hh:mm");

    return Booking(
      id: dto.id,
      order: Order.fromDTO(dto.order),
      court: Court.fromDTO(dto.court),
      date: dateFormatter.parse(dto.date),
      startTime: timeFormatter.parse(dto.startTime),
      endTime: timeFormatter.parse(dto.endTime),
    );
  }
}
