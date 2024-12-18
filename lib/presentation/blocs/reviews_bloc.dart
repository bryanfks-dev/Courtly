import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/reviews_stats.dart';
import 'package:courtly/domain/usecases/review_usecase.dart';
import 'package:courtly/presentation/blocs/states/reviews_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ReviewsBloc] is the business logic component for reviews.
class ReviewsBloc extends Cubit<ReviewsState> {
  /// [reviewUsecase] is the review usecase.
  final ReviewUsecase reviewUsecase;

  ReviewsBloc({required this.reviewUsecase}) : super(ReviewsInitialState());

  /// [getReviews] is a method to get the reviews.
  ///
  /// Paramters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [courtType] is the type of the court.
  ///   - [rating] is the rating of the review.
  ///
  /// Returns a [Future] of [void].
  Future<void> getReviews(
      {required int vendorId, required String courtType, int? rating}) async {
    emit(ReviewsLoadingState());

    // Get the reviews from the usecase.
    final Either<Failure, ReviewsStats> res = await reviewUsecase.getReviews(
        vendorId: vendorId, courtType: courtType, rating: rating);

    // Handle the result.
    res.fold(
        (l) => emit(ReviewsErrorState(errorMessage: l.errorMessage)),
        (ReviewsStats r) => emit(ReviewsLoadedState(
            reviewStars: r.reviewStars,
            reviews: r.reviews,
            totalRating: r.totalRating,
            totalReviews: r.totalReviews)));
  }
}
