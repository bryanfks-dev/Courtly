import 'package:courtly/data/dto/order_dto.dart';
import 'package:courtly/domain/entities/vendor.dart';
import 'package:intl/intl.dart';

/// [Order] is a class that holds the information of an order.
class Order {
  /// [id] is the unique identifier for the order.
  final int id;

  /// [date] is the date of the order.
  final DateTime date;

  /// [courtType] is the type of the court.
  final String courtType;

  /// [vendor] is the vendor of the order.
  final Vendor vendor;

  /// [paymentMethod] is the payment method of the order.
  final String paymentMethod;

  /// [price] is the price of the order.
  final double price;

  /// [appFee] is the application fee of the order.
  final double appFee;

  /// [status] is the status of the order.
  final String status;

  /// [reviewed] is a boolean value that indicates whether the order
  /// is reviewed or not.
  final bool? reviewed;

  Order(
      {required this.id,
      required this.date,
      required this.courtType,
      required this.vendor,
      required this.paymentMethod,
      required this.price,
      required this.appFee,
      required this.status,
      this.reviewed});

  /// [fromDTO] is a factory method that converts the [OrderDTO] object to a [Order] object.
  ///
  /// Parameters:
  ///   - [dto] is the [OrderDTO] object.
  ///
  /// Returns a [Order] object.
  factory Order.fromDTO(OrderDTO dto) {
    // Create a date formatter
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    return Order(
      id: dto.id,
      date: dateFormatter.parse(dto.date),
      courtType: dto.courtType,
      vendor: Vendor.fromDTO(dto.vendor),
      paymentMethod: dto.paymentMethod,
      price: dto.price,
      appFee: dto.appFee,
      status: dto.status,
      reviewed: dto.reviewed,
    );
  }
}
