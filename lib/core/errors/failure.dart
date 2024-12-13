/// [Failure] is a base class for all errors that can occur in the application.
abstract class Failure {
  /// [errorMessage] is the error message that will be displayed to the user.
  final dynamic errorMessage;

  const Failure(this.errorMessage);
}

/// [NetworkFailure] is a class for network errors.
/// This error occurs when the device is not connected to the internet.
class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.errorMessage =
          "Network failure, please check your internet connection."]);
}

/// [RequestFailure] is a class for request
/// This error occurs when the request times out.
class RequestFailure extends Failure {
  const RequestFailure(
      [super.errorMessage = "Request timed out, please try again."]);
}

/// [ServerFailure] is a class for server errors.
/// This error occurs when the server returns an error.
class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);
}

/// [FormFailure] is a class for form errors.
/// This error occurs when the form data is invalid.
class FormFailure extends Failure {
  const FormFailure(super.errorMessage);
}

/// [UnknownFailure] is a class for unknown errors.
/// This error occurs when an unknown error occurs.
class UnknownFailure extends Failure {
  const UnknownFailure(super.errorMessage);
}
