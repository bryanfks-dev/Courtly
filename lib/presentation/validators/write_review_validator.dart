/// [WriteReviewValidator] is a class that validates the rating value
class WriteReviewValidator {
  /// [validateRating] is a method that validates the rating value
  ///
  /// Paramters:
  ///   - [value] is the rating value
  ///
  /// Returns [String]
  String? validateRating(int value) {
    // Check if the value is 0
    if (value == 0) {
      return 'Please choose rating';
    }

    return null;
  }
}
