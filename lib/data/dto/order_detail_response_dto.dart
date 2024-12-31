import 'package:courtly/data/dto/order_detail_dto.dart';

class OrderDetailResponseDTO {
  /// [orderDetail] is the order detail.
  final OrderDetailDTO orderDetail;

  OrderDetailResponseDTO({required this.orderDetail});

  /// [fromJson] is a factory method that creates an [OrderDetailResponse] instance
  /// from a JSON object.
  ///
  /// Parameters:
  ///   - [json] is a JSON object.
  ///
  /// Returns an [OrderDetailResponse] instance.
  factory OrderDetailResponseDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponseDTO(
      orderDetail: OrderDetailDTO.fromJson(json['order_detail']),
    );
  }
}
