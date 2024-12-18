import 'package:courtly/domain/entities/review.dart';
import 'package:courtly/domain/entities/review_stars.dart';

/// [ReviewsState] is the abstract class that will be extended by the different states of the reviews bloc.
abstract class ReviewsState {}

/// [ReviewsLoadingState] is the state when the reviews are being loaded.
/// This state will be used to display a loading indicator.
class ReviewsInitialState extends ReviewsState {}

/// [ReviewsLoadingState] is the state when the reviews are being loaded.
/// This state will be used to display a loading indicator.
class ReviewsLoadingState extends ReviewsState {}

/// [ReviewsLoadedState] is the state when the reviews are loaded.
/// This state will be used to display the reviews.
class ReviewsLoadedState extends ReviewsState {
  /// [reviewStars] is the review stars.
  final ReviewStars reviewStars;

  /// [reviews] is the list of reviews.
  final List<Review> reviews;

  /// [totalRating] is the total rating.
  final double totalRating;

  /// [totalReviews] is the total reviews.
  final int totalReviews;

  /// [reviews] is the list of reviews.
  ReviewsLoadedState(
      {required this.reviewStars,
      required this.reviews,
      required this.totalRating,
      required this.totalReviews});
}

/// [ReviewsErrorState] is the state when there is an error loading the reviews.
/// This state will be used to display an error message.
class ReviewsErrorState extends ReviewsState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  ReviewsErrorState({required this.errorMessage});
}
