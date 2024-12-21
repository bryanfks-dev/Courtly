import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/review.dart';
import 'package:courtly/domain/usecases/review_usecase.dart';
import 'package:courtly/presentation/blocs/states/write_review_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [WriteReviewBloc] is a bloc that is used to manage the write review
class WriteReviewBloc extends Cubit<WriteReviewState> {
  /// [WriteReviewBloc] is a bloc that is used to manage the write review
  final ReviewUsecase reviewUsecase;

  WriteReviewBloc({required this.reviewUsecase})
      : super(WriteReviewInitialState());

  /// [submitReview] is a function that is used to submit a review.
  ///
  /// Parameters:
  ///   - [vendorId] is the vendor id.
  ///   - [courtType] is the court type.
  ///   - [rating] is the rating.
  ///   - [review] is the review.
  ///
  /// Returns [Future] of [void]
  Future<void> submitReview({
    required int vendorId,
    required String courtType,
    required int rating,
    required String review,
  }) async {
    emit(WriteReviewLoadingState());

    // Create a review
    final Either<Failure, Review> res = await reviewUsecase.createReview(
      vendorId: vendorId,
      courtType: courtType,
      rating: rating,
      review: review,
    );

    res.fold(
      (l) => emit(WriteReviewErrorState(errorMessage: l.errorMessage)),
      (r) => emit(WriteReviewSuccessState()),
    );
  }
}
