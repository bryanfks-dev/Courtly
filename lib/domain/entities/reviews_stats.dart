import 'package:courtly/domain/entities/review.dart';
import 'package:courtly/domain/entities/review_stars.dart';

/// [ReviewsStats] is the entity for the reviews stats.
class ReviewsStats {
  /// [reviews] is the list of reviews.
  final List<Review> reviews;

  /// [reviewStars] is the review stars.
  final ReviewStars reviewStars;

  /// [totalReviews] is the total reviews.
  final int totalReviews;

  /// [totalRating] is the total rating.
  final double totalRating;

  ReviewsStats(
      {required this.reviews,
      required this.reviewStars,
      required this.totalReviews,
      required this.totalRating});
}
