import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/create_review_form_dto.dart';
import 'package:courtly/data/dto/review_dto.dart';
import 'package:courtly/data/dto/reviews_response_dto.dart';
import 'package:courtly/data/repository/api/review_repository.dart';
import 'package:courtly/domain/entities/review.dart';
import 'package:courtly/domain/entities/review_stars.dart';
import 'package:courtly/domain/entities/reviews_stats.dart';
import 'package:dartz/dartz.dart';

/// [ReviewUsecase] is the usecase for the review.
class ReviewUsecase {
  /// [ReviewUsecase] is the usecase for the review.
  final ReviewRepository reviewRepository;

  ReviewUsecase({required this.reviewRepository});

  /// [getReviews] is a method to get the reviews.
  Future<Either<Failure, ReviewsStats>> getReviews(
      {required int vendorId, required String courtType, int? rating}) async {
    // Get the reviews from the repository.
    final Either<Failure, ReviewsResponseDTO> res = await reviewRepository
        .getReviews(vendorId: vendorId, courtType: courtType, rating: rating);

    // Return the reviews stats.
    return res.fold(
        (Failure l) => Left(l),
        (ReviewsResponseDTO r) => Right(ReviewsStats(
            reviews: r.reviews.map((x) => Review.fromDTO(x)).toList(),
            reviewStars: ReviewStars.fromDTO(r.reviewStars),
            totalReviews: r.reviewsTotal,
            totalRating: r.totalRating)));
  }

  /// [createReview] is a method to create a review.
  /// This method is used to create a review.
  ///
  /// Parameters:
  ///   - [vendorId] is the vendor id.
  ///   - [courtType] is the court type.
  ///   - [rating] is the rating.
  ///   - [review] is the review.
  ///
  /// Returns [Future] of [Either] of [Failure] or [Review].
  Future<Either<Failure, Review>> createReview(
      {required int vendorId,
      required String courtType,
      required int rating,
      required String review}) async {
    // Create create review form dto
    final CreateReviewFormDTO reviewDTO =
        CreateReviewFormDTO(rating: rating, review: review);

    // Create the review from the repository.
    final Either<Failure, ReviewDTO> res = await reviewRepository.postReview(
        vendorId: vendorId, courtType: courtType, formDto: reviewDTO);

    // Return the review.
    return res.fold(
        (Failure l) => Left(l), (ReviewDTO r) => Right(Review.fromDTO(r)));
  }
}
