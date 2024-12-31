import 'package:courtly/data/dto/booking_dto.dart';

/// [OrderDetailDTO] is a data transfer object that represents an order detail.
class OrderDetailDTO {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [midtransOrderId] is the Midtrans order ID of the order.
  final String midtransOrderId;

  /// [orderDate] is the order date of the order.
  final String orderDate;

  /// [createdDate] is the created date of the order.
  final String createdDate;

  /// [price] is the price of the order.
  final double price;

  /// [appFee] is the application fee of the order.
  final double appFee;

  /// [paymentToken] is the payment token of the order.
  final String paymentToken;

  /// [status] is the status of the order.
  final String status;

  /// [bookings] is the booking details of the order.
  final List<BookingDTO> bookings;

  OrderDetailDTO({
    required this.id,
    required this.midtransOrderId,
    required this.orderDate,
    required this.createdDate,
    required this.price,
    required this.appFee,
    required this.paymentToken,
    required this.status,
    required this.bookings,
  });

  /// [fromJson] is a factory method that creates an [OrderDetailDTO] instance
  /// from a json object.
  ///
  /// Parameters:
  ///   - [json] is a JSON object.
  ///
  /// Returns an [OrderDetailDTO] instance.
  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailDTO(
      id: json['id'],
      midtransOrderId: json['midtrans_order_id'],
      orderDate: json['order_date'],
      createdDate: json['created_date'],
      price: json['price'] + .0,
      appFee: json['app_fee'] + .0,
      paymentToken: json['payment_token'],
      status: json['status'],
      bookings: (json['bookings'] as List)
          .map((x) => BookingDTO.fromJson(x))
          .toList(),
    );
  }
}
