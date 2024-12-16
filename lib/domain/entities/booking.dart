import 'package:courtly/data/dto/booking_dto.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/domain/entities/order.dart';

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
    return Booking(
      id: dto.id,
      order: Order.fromDTO(dto.order),
      court: Court.fromDTO(dto.court),
      date: DateTime.parse(dto.date),
      startTime: DateTime.parse(dto.startTime),
      endTime: DateTime.parse(dto.endTime),
    );
  }
}
