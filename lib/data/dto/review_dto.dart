import 'package:courtly/data/dto/user_dto.dart';

/// [ReviewDTO] is a data transfer object for the review entity.
class ReviewDTO {
  /// [id] is the unique identifier of the review.
  final int id;

  /// [user] is the user who wrote the review.
  final UserDTO user;

  /// [courtType] is the type of court that was reviewed.
  final String courtType;

  /// [rating] is the rating given by the user.
  final int rating;

  /// [review] is the review written by the user.
  final String review;

  /// [date] is the date when the review was written.
  final String date;

  ReviewDTO({
    required this.id,
    required this.user,
    required this.courtType,
    required this.rating,
    required this.review,
    required this.date,
  });

  /// [fromJson] is a factory method that creates a [ReviewDTO] instance from a JSON object.
  ///
  /// Parameters:
  ///   - [json] a JSON object.
  ///
  /// Returns: A [ReviewDTO] instance.
  factory ReviewDTO.fromJson(Map<String, dynamic> json) {
    return ReviewDTO(
      id: json['id'],
      user: UserDTO.fromJson(json['user']),
      courtType: json['court_type'],
      rating: json['rating'],
      review: json['review'],
      date: json['date'],
    );
  }
}
