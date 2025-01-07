import 'package:courtly/data/dto/advertisement_dto.dart';

/// [AdvertisementResponseDTO] is the data transfer object of
/// the advertisement response.
class AdvertisementResponseDTO {
  /// [ads] is the list of [AdvertisementDTO].
  final List<AdvertisementDTO> ads;

  AdvertisementResponseDTO({required this.ads});

  /// [fromJson] is a factory method that creates an instance of
  /// [AdvertisementResponseDTO]
  ///
  /// Paramters:
  ///   - [json] is the JSON object.
  ///
  /// Returns [AdvertisementResponseDTO]
  factory AdvertisementResponseDTO.fromJson(Map<String, dynamic> json) {
    return AdvertisementResponseDTO(
        ads: (json["ads"] as List)
            .map((x) => AdvertisementDTO.fromJson(x))
            .toList());
  }
}
