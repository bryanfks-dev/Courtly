import 'package:courtly/data/dto/order_detail_dto.dart';
import 'package:courtly/domain/entities/booking.dart';
import 'package:intl/intl.dart';

/// [OrderDetail] is an entity that represents an order detail.
class OrderDetail {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [midtransOrderId] is the Midtrans order ID of the order.
  final String midtransOrderId;

  /// [orderDate] is the order date of the order.
  final DateTime orderDate;

  /// [createdDate] is the created date of the order.
  final DateTime createdDate;

  /// [price] is the price of the order.
  final double price;

  /// [appFee] is the application fee of the order.
  final double appFee;

  /// [paymentToken] is the payment token of the order.
  final String paymentToken;

  /// [status] is the status of the order.
  final String status;

  /// [bookings] is the booking details of the order.
  final List<Booking> bookings;

  OrderDetail({
    required this.id,
    required this.midtransOrderId,
    required this.price,
    required this.appFee,
    required this.orderDate,
    required this.createdDate,
    required this.paymentToken,
    required this.status,
    required this.bookings,
  });

  /// [fromDTO] is a factory method that creates an [OrderDetail] instance
  /// from an [OrderDetailDTO] instance.
  /// 
  /// Parameters:
  ///   - [dto] is an [OrderDetailDTO] instance.
  /// 
  /// Returns an [OrderDetail] instance.
  factory OrderDetail.fromDTO(OrderDetailDTO dto) {
    /// [dateFormatter] is a date formatter.
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    return OrderDetail(
      id: dto.id,
      midtransOrderId: dto.midtransOrderId,
      price: dto.price,
      appFee: dto.appFee,
      orderDate: dateFormatter.parse(dto.orderDate),
      createdDate: dateFormatter.parse(dto.createdDate),
      paymentToken: dto.paymentToken,
      status: dto.status,
      bookings: dto.bookings.map((e) => Booking.fromDTO(e)).toList(),
    );
  }
}
