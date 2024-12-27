/// ChangeProfilePictureDTO is a data transfer object class.
class ChangeProfilePictureDTO {
  /// [image] is the image of the user.
  final String image;

  ChangeProfilePictureDTO({required this.image});

  /// [fromJson] converts the json to the [ChangeProfilePictureDTO] object.
  ///
  /// Returns [ChangeProfilePictureDTO]
  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}
