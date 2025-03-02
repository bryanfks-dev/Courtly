import 'package:courtly/data/dto/vendor_dto.dart';

/// [OrderDTO] is a data transfer object that represents an order.
class OrderDTO {
  /// [id] is the unique identifier of the order.
  final int id;

  /// [date] is the date of the order.
  final String date;

  /// [courtType] is the type of the court.
  final String courtType;

  /// [vendor] is the vendor of the order.
  final VendorDTO vendor;

  /// [price] is the price of the order.
  final double price;

  /// [appFee] is the application fee of the order.
  final double appFee;

  /// [paymentToken] is the payment token of the order.
  final String paymentToken;

  /// [status] is the status of the order.
  final String status;

  /// [reviewed] is a boolean value that indicates whether the order
  /// is reviewed or not.
  final bool? reviewed;

  OrderDTO({
    required this.id,
    required this.date,
    required this.courtType,
    required this.vendor,
    required this.price,
    required this.appFee,
    required this.paymentToken,
    required this.status,
    this.reviewed,
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
      date: json['date'],
      courtType: json['court_type'],
      vendor: VendorDTO.fromJson(json['vendor']),
      price: json['price'] + .0,
      appFee: json['app_fee'] + .0,
      paymentToken: json['payment_token'],
      status: json['status'],
      reviewed: json['reviewed'],
    );
  }
}
