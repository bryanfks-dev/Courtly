import 'package:courtly/data/dto/review_starts_dto.dart';

/// [ReviewStars] is a class that represents the review stars.
class ReviewStars {
  /// [oneStar] is the number of one star reviews
  final int oneStar;

  /// [twoStar] is the number of two star reviews
  final int twoStar;

  /// [threeStar] is the number of three star reviews
  final int threeStar;

  /// [fourStar] is the number of four star reviews
  final int fourStar;

  /// [fiveStar] is the number of five star reviews
  final int fiveStar;

  ReviewStars({
    required this.oneStar,
    required this.twoStar,
    required this.threeStar,
    required this.fourStar,
    required this.fiveStar,
  });

  /// [fromDTO] is a factory constructor to create a [ReviewStars] from a DTO.
  ///
  /// Parameters:
  ///   - [dto] is a [ReviewStarsDTO] object.
  ///
  /// Returns a [ReviewStars] object.
  factory ReviewStars.fromDTO(ReviewStarsDTO dto) {
    return ReviewStars(
      oneStar: dto.oneStar,
      twoStar: dto.twoStars,
      threeStar: dto.threeStars,
      fourStar: dto.fourStars,
      fiveStar: dto.fiveStars,
    );
  }
}
