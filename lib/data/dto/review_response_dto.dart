import 'package:courtly/data/dto/review_dto.dart';

/// [ReviewResponseDTO] is a data transfer object to handle review response.
class ReviewResponseDTO {
  /// [review] is the review dto.
  final ReviewDTO review;

  ReviewResponseDTO({required this.review});

  /// [fromJson] is a function to parse json to [ReviewResponseDTO].
  ///
  /// Parameters:
  ///   - [json] is the json to parse.
  ///
  /// Returns a [ReviewResponseDTO].
  factory ReviewResponseDTO.fromJson(Map<String, dynamic> json) {
    return ReviewResponseDTO(
      review: ReviewDTO.fromJson(json["review"]),
    );
  }
}
