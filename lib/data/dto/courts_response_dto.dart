import 'package:courtly/data/dto/court_dto.dart';

/// [CourtsResponseDTO] is a class that holds the response of the courts.
class CourtsResponseDTO {
  /// [courts] is the list of courts.
  final List<CourtDTO> courts;

  CourtsResponseDTO({required this.courts});

  /// [fromJson] method is used to convert the JSON object to a [CourtsResponseDTO] object.
  ///
  /// Parameters:
  ///   - [json] is the JSON object to be converted.
  ///
  /// Returns a [CourtsResponseDTO] object.
  factory CourtsResponseDTO.fromJson(Map<String, dynamic> json) {
    return CourtsResponseDTO(
      courts: (json['courts'] as List<dynamic>)
          .map((court) => CourtDTO.fromJson(court))
          .toList(),
    );
  }
}
