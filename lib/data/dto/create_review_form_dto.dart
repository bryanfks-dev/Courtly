/// [CreateReviewFormDTO] is a data transfer object for creating a review.
class CreateReviewFormDTO {
  /// [rating] is the rating of the review.
  final int rating;

  /// [review] is the review of the review.
  final String review;

  CreateReviewFormDTO({
    required this.rating,
    required this.review,
  });

  /// [toJson] is a function to convert the object to a json object.
  ///
  /// Returns a [Map] of [String] and [dynamic].
  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating': rating,
    };
  }
}
