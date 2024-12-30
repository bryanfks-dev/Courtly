/// CreateOrderResponseDTO is a data transfer object class which is used to
/// parse the response of create order API.
class CreateOrderResponseDTO {
  /// [paymentToken] is the payment token of the order.
  final String paymentToken;

  CreateOrderResponseDTO({required this.paymentToken});

  /// [fromJson] is a factory method that creates a [CreateOrderResponseDTO]
  /// instance from a JSON object.
  /// 
  /// Parameters:
  ///   - [json] is a JSON object.
  /// 
  /// Returns a [CreateOrderResponseDTO] instance.
  factory CreateOrderResponseDTO.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponseDTO(
      paymentToken: json['payment_token'],
    );
  }
}
