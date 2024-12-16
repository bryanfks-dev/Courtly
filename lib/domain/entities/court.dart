import 'package:courtly/core/config/api_server_config.dart';
import 'package:courtly/data/dto/court_dto.dart';
import 'package:courtly/domain/entities/vendor.dart';

/// [Court] is a class that holds the information of a court.
class Court {
  /// [id] is the unique identifier for the court.
  final int id;

  /// [name] is the name of the court.
  final String name;

  /// [vendor] is the vendor of the court.
  final Vendor vendor;

  /// [type] is the type of the court.
  final String type;

  /// [price] is the price of the court.
  final double price;

  /// [rating] is the rating of the court.
  final double rating;

  /// [imageUrl] is the image URL of the court.
  final String imageUrl;

  Court({
    required this.id,
    required this.name,
    required this.vendor,
    required this.type,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  /// [fromDTO] is a factory constructor that creates a [Court] instance from a [CourtDTO].
  ///
  /// Parameters:
  ///   - [dto]: The [CourtDTO] instance to be converted.
  ///
  /// Returns a [Court] instance.
  factory Court.fromDTO(CourtDTO dto) {
    return Court(
        id: dto.id,
        name: dto.name,
        vendor: Vendor.fromDTO(dto.vendor),
        type: dto.type,
        price: dto.price,
        rating: dto.rating,
        imageUrl: "${ApiServerConfig.baseUrl}/${dto.imageUrl}");
  }
}
