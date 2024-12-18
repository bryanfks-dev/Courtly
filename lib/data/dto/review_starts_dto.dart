/// [ReviewStarsDTO] is a data transfer object for review stars.
class ReviewStarsDTO {
  /// [oneStar] is the number of one star reviews.
  final int oneStar;

  /// [twoStars] is the number of two star reviews.
  final int twoStars;

  /// [threeStars] is the number of three star reviews.
  final int threeStars;

  /// [fourStars] is the number of four star reviews.
  final int fourStars;

  /// [fiveStars] is the number of five star reviews.
  final int fiveStars;

  ReviewStarsDTO({
    required this.oneStar,
    required this.twoStars,
    required this.threeStars,
    required this.fourStars,
    required this.fiveStars,
  });

  /// [fromJson] is a factory method that creates a [ReviewStarsDTO] instance from a JSON object.
  ///
  /// Parameters:
  ///   - [json] a JSON object.
  ///
  /// Returns a [ReviewStarsDTO] instance.
  factory ReviewStarsDTO.fromJson(Map<String, dynamic> json) {
    return ReviewStarsDTO(
      oneStar: json['1'],
      twoStars: json['2'],
      threeStars: json['3'],
      fourStars: json['4'],
      fiveStars: json['5'],
    );
  }
}
