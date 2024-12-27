/// [CreateOrderDTO] is a class that holds the properties of a booking.
class CreateOrderDTO {
  /// [vendorId] is the id of the vendor.
  final int vendorId;

  /// [date] is the date of the booking.
  final String date;

  /// [paymentMethod] is the payment method.
  final String paymentMethod;

  /// [bookings] is the list of bookings.
  final List<CreateBookingsInnerDTO> bookings;

  CreateOrderDTO({
    required this.vendorId,
    required this.date,
    required this.paymentMethod,
    required this.bookings,
  });

  /// [toJson] is a function that converts the object to a JSON object.
  ///
  /// Returns a [Map] of [String] and [dynamic].
  Map<String, dynamic> toJson() {
    return {
      "vendor_id": vendorId,
      "date": date,
      "payment_method": paymentMethod,
      "bookings": bookings.map((e) => e.toJson()).toList(),
    };
  }
}

/// [CreateBookingsInnerDTO] is a class that holds the properties of a booking.
class CreateBookingsInnerDTO {
  /// [courtId] is the id of the court.
  final int courtId;

  /// [bookTimes] is the list of booking times.
  final List<String> bookTimes;

  CreateBookingsInnerDTO({
    required this.courtId,
    required this.bookTimes,
  });

  /// [toJson] is a function that converts the object to a JSON object.
  ///
  /// Returns a [Map] of [String] and [dynamic].
  Map<String, dynamic> toJson() {
    return {
      "court_id": courtId,
      "book_times": bookTimes,
    };
  }
}
