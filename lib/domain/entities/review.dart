import 'package:courtly/data/dto/review_dto.dart';
import 'package:courtly/domain/entities/user.dart';
import 'package:intl/intl.dart';

/// [Review] is a data transfer object for the review entity.
class Review {
  /// [id] is the unique identifier of the review.
  final int id;

  /// [user] is the user who wrote the review.
  final User user;

  /// [courtType] is the type of court that was reviewed.
  final String courtType;

  /// [rating] is the rating given by the user.
  final int rating;

  /// [review] is the review written by the user.
  final String review;

  /// [date] is the date when the review was written.
  final DateTime date;

  Review({
    required this.id,
    required this.user,
    required this.courtType,
    required this.rating,
    required this.review,
    required this.date,
  });

  /// [fromDTO] is a factory method that creates a [Review] instance from a [ReviewDTO] object.
  ///
  /// Parameters:
  ///   - [dto] a [ReviewDTO] object.
  ///
  /// Returns a [Review] instance.
  factory Review.fromDTO(ReviewDTO dto) {
    /// [dateFormatter] is a date formatter object.
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    return Review(
      id: dto.id,
      user: User.fromDTO(dto.user),
      courtType: dto.courtType,
      rating: dto.rating,
      review: dto.review,
      date: dateFormatter.parse(dto.date),
    );
  }
}
