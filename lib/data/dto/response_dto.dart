/// [ResponseDTO] is a generic class that holds the response from the API.
class ResponseDTO<T> {
  /// [success] is a boolean value that indicates whether the request was successful or not.
  final bool success;

  /// [message] is a dynamic value that holds the message from the API.
  final dynamic message;

  /// [data] is a generic value that holds the data from the API.
  final T? data;

  ResponseDTO(
      {required this.success, required this.message, required this.data});

  /// [fromJson] is a factory method to create a [ResponseDTO] from a map.
  ///
  /// Returns a [ResponseDTO] object.
  factory ResponseDTO.fromJson(
      {required Map<String, dynamic> json,
      T Function(Map<String, dynamic>)? fromJsonT}) {
    // Check if the data is null.
    if (json['data'] == null) {
      return ResponseDTO(
        success: json['success'],
        message: json['message'],
        data: null,
      );
    }

    return ResponseDTO(
      success: json['success'],
      message: json['message'],
      data: fromJsonT!(json['data']),
    );
  }
}
