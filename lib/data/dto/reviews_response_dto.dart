import 'package:courtly/data/dto/review_dto.dart';
import 'package:courtly/data/dto/review_starts_dto.dart';

/// [ReviewsResponseDTO] is a data transfer object for reviews response.
class ReviewsResponseDTO {
  /// [totalRating] is the total rating of the reviews.
  final double totalRating;

  /// [reviewsTotal] is the total number of reviews.
  final int reviewsTotal;

  /// [reviewStars] is the review stars.
  final ReviewStarsDTO reviewStars;

  /// [reviews] is the reviews.
  final List<ReviewDTO> reviews;

  ReviewsResponseDTO({
    required this.totalRating,
    required this.reviewsTotal,
    required this.reviewStars,
    required this.reviews,
  });

  /// [fromJson] is a factory method that creates a [ReviewsResponseDTO] instance from a JSON object.
  ///
  /// Parameters:
  ///   - [json]: A JSON object.
  ///
  /// Returns a [ReviewsResponseDTO] instance.
  factory ReviewsResponseDTO.fromJson(Map<String, dynamic> json) {
    return ReviewsResponseDTO(
      totalRating: json['total_rating'] + .0,
      reviewsTotal: json['reviews_total'],
      reviewStars: ReviewStarsDTO.fromJson(json['stars']),
      reviews: (json['reviews'] as List)
          .map((review) => ReviewDTO.fromJson(review))
          .toList(),
    );
  }
}
