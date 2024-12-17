/// [OrderDTO] is a data transfer object that represents an order.
class OrderDTO {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [paymentMethod] is the payment method used for the order.
  final String paymentMethod;

  /// [price] is the price of the order.
  final double price;

  /// [appFee] is the application fee of the order.
  final double appFee;

  /// [status] is the status of the order.
  final String status;

  OrderDTO({
    required this.id,
    required this.paymentMethod,
    required this.price,
    required this.appFee,
    required this.status,
  });

  /// [fromJson] is a factory method that creates an [OrderDTO] instance from a JSON object.
  ///
  /// Parameters:
  ///   - [json] is a JSON object.
  ///
  /// Returns an [OrderDTO] instance.
  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      id: json['id'],
      paymentMethod: json['payment_method'],
      price: json['price'] + .0,
      appFee: json['appFee'] + .0,
      status: json['status'],
    );
  }
}
