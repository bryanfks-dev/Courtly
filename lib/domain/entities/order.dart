import 'package:courtly/data/dto/order_dto.dart';

/// [Order] is a class that holds the information of an order.
class Order {
  /// [id] is the unique identifier for the order.
  final int id;

  /// [paymentMethod] is the payment method of the order.
  final String paymentMethod;

  /// [price] is the price of the order.
  final double price;

  /// [status] is the status of the order.
  final String status;

  Order({
    required this.id,
    required this.paymentMethod,
    required this.price,
    required this.status,
  });

  /// [fromDTO] is a factory method that converts the [OrderDTO] object to a [Order] object.
  ///
  /// Parameters:
  ///   - [dto] is the [OrderDTO] object.
  ///
  /// Returns a [Order] object.
  factory Order.fromDTO(OrderDTO dto) {
    return Order(
      id: dto.id,
      paymentMethod: dto.paymentMethod,
      price: dto.price,
      status: dto.status,
    );
  }
}
