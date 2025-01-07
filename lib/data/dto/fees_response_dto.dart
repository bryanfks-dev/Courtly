/// [FeesResponseDTO] is a data transfer object for fees response.
class FeesResponseDTO {
  /// [appFee] is the application fee.
  final double appFee;

  FeesResponseDTO({required this.appFee});

  /// [fromJson] is used to convert a map of key value pairs to an instance
  /// of the class [FeesResponseDTO]
  ///
  /// Parameters:
  ///   - [json] is a map of key value pairs
  ///
  /// Returns an instance of the class [FeesResponseDTO]
  factory FeesResponseDTO.fromJson(Map<String, dynamic> json) {
    return FeesResponseDTO(
      appFee: json['app_fee'] + .0,
    );
  }
}
