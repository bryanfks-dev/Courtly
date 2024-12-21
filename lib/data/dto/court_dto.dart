import 'package:courtly/data/dto/vendor_dto.dart';

/// [CourtDTO] is a class that holds the information of a court.
class CourtDTO {
  /// [id] is the unique identifier for the court.
  final int id;

  /// [name] is the name of the court.
  final String name;

  /// [vendor] is the vendor of the court.
  final VendorDTO vendor;

  /// [type] is the type of the court.
  final String type;

  /// [price] is the price of the court.
  final double price;

  /// [rating] is the rating of the court.
  final double? rating;

  /// [imageUrl] is the image URL of the court.
  final String imageUrl;

  CourtDTO({
    required this.id,
    required this.name,
    required this.vendor,
    required this.type,
    required this.price,
    this.rating,
    required this.imageUrl,
  });

  /// [fromJson] is a function that converts a [Map] to a [CourtDTO].
  ///
  /// Parameters:
  ///   - [map] is a [Map] that contains the data of a [CourtDTO].
  ///
  /// Returns a [CourtDTO].
  factory CourtDTO.fromJson(Map<String, dynamic> map) {
    return CourtDTO(
      id: map['id'],
      name: map['name'],
      vendor: VendorDTO.fromJson(map['vendor']),
      type: map['type'],
      price: map['price'] + .0,
      rating: map['rating'] + .0,
      imageUrl: map['image_url'],
    );
  }
}
