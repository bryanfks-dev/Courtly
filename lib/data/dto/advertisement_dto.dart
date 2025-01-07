import 'package:courtly/data/dto/vendor_dto.dart';

/// [AdvertisementDTO] is a data transfer object class for advertisement.
class AdvertisementDTO {
  /// [id] is the id of advertisement
  final int id;

  /// [imageUrl] is the url of the image of the advertisement
  final String imageUrl;

  /// [vendor] is the vendor of the advertisement
  final VendorDTO vendor;

  /// [courtType] is the court type of the vendor advertisement
  final String courtType;

  AdvertisementDTO(
      {required this.id,
      required this.imageUrl,
      required this.vendor,
      required this.courtType});

  /// [fromJson] is a factory method to create an instance of
  /// [AdvertisementDTO] from a json.
  ///
  /// Parameters:
  ///   - [json] is a map of string and dynamic
  ///
  /// Returns an instance of [AdvertisementDTO]
  factory AdvertisementDTO.fromJson(Map<String, dynamic> json) {
    return AdvertisementDTO(
        id: json['id'],
        imageUrl: json['image_url'],
        vendor: VendorDTO.fromJson(json['vendor']),
        courtType: json['court_type']);
  }
}
