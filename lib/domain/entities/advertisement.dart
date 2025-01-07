import 'package:courtly/core/config/api_server_config.dart';
import 'package:courtly/data/dto/advertisement_dto.dart';
import 'package:courtly/domain/entities/vendor.dart';

/// [Advertisement] is an entity for advertisement.
class Advertisement {
  /// [id] is the id of the advertisement.
  final int id;

  /// [imageUrl] is the image URL of the advertisement.
  final String imageUrl;

  /// [vendor] is the vendor of the advertisement.
  final Vendor vendor;

  /// [courtType] is the court type of the advertisement.
  final String courtType;

  Advertisement({
    required this.id,
    required this.imageUrl,
    required this.vendor,
    required this.courtType,
  });

  /// [fromDTO] is a factory method to create an [Advertisement]
  /// from an [AdvertisementDTO].
  ///
  /// Parameters:
  ///   - [dto] is an instance of [AdvertisementDTO].
  ///
  /// Returns an [Advertisement] object.
  factory Advertisement.fromDTO(AdvertisementDTO dto) {
    return Advertisement(
      id: dto.id,
      imageUrl: "${ApiServerConfig.baseUrl}/${dto.imageUrl}",
      vendor: Vendor.fromDTO(dto.vendor),
      courtType: dto.courtType,
    );
  }
}
