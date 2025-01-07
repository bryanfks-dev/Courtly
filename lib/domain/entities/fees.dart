import 'package:courtly/data/dto/fees_response_dto.dart';

/// [Fees] is an entity for fees.
class Fees {
  /// [appFee] is the application fee.
  final double appFee;

  Fees({required this.appFee});

  /// [fromDTO] is a function to convert a [FeesResponseDTO] to a [Fees].
  /// 
  /// Parameters:
  ///   - [dto] is an instance of [FeesResponseDTO]
  /// 
  /// Returns an instance of [Fees]
  factory Fees.fromDTO(FeesResponseDTO dto) {
    return Fees(appFee: dto.appFee);
  }
}
