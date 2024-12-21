/// [BookValueProps] is a class that holds the properties of a booking
class BookingValueProps {
  /// [time] is the time of the booking
  final String time;

  /// [courtId] is the id of the court
  final int courtId;

  BookingValueProps({
    required this.time,
    required this.courtId,
  });
}
