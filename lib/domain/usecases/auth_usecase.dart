import 'package:courtly/data/repository/local/token_repository.dart';

/// [AuthUsecase] is a class that contains the business logic of the authentication process.
class AuthUsecase {
  /// [tokenRepository] is the repository for token.
  final TokenRepository tokenRepository;

  AuthUsecase({required this.tokenRepository});

  /// [tokenAvailable] is a method to check if the token is available.
  ///
  /// Returns a [Future] of [bool].
  Future<bool> tokenAvailable() async {
    // Get the token from the repository
    final String? token = await tokenRepository.getToken();

    // Check if the token is null
    return token != null;
  }
}
