import 'package:courtly/core/errors/failure.dart';
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
    return res.fold((Failure l) => Left(l), (ReviewsResponseDTO r) {
      return Right(ReviewsStats(
          reviews: r.reviews.map((x) => Review.fromDTO(x)).toList(),
          reviewStars: ReviewStars.fromDTO(r.reviewStars),
          totalReviews: r.reviewsTotal,
          totalRating: r.totalRating));
    });
  }
}
