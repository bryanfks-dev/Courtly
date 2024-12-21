import 'package:courtly/data/dto/order_dto.dart';

/// [OrdersResponseDTO] is a class that contains the list of orders.
class OrdersResponseDTO {
  /// [orders] is the list of orders.
  final List<OrderDTO> orders;
  
  OrdersResponseDTO({
    required this.orders,
  });

  /// [fromJson] is a function that converts a [Map] to a [OrdersResponseDTO].
  /// 
  /// Parameters:
  ///   - [json] is a [Map] that contains the data of a [OrdersResponseDTO].
  /// 
  /// Returns a [OrdersResponseDTO].
  factory OrdersResponseDTO.fromJson(Map<String, dynamic> json) {
    return OrdersResponseDTO(
        orders: 
            (json["orders"] as List).map((x) => OrderDTO.fromJson(x)).toList()
      );
  }
} 