import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/repository/api/logout_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';

/// [LogoutUsecase] is a usecase class that contains the logout data for the app.
class LogoutUsecase {
  /// [logoutRepository] is a repository class that contains the logout data for the app.
  final LogoutRepository logoutRepository;

  /// [tokenRepository] is a repository class that contains the token data for the app.
  final TokenRepository tokenRepository;

  LogoutUsecase(
      {required this.logoutRepository, required this.tokenRepository});

  /// [logout] is a method that logs out the user from the app.
  ///
  /// Returns a [Future] of [Failure].
  Future<Failure?> logout() async {
    // Logout the user
    final Failure? res = await logoutRepository.logout();

    // Check if the logout was successful
    if (res != null) {
      return res;
    }

    // Clear the token
    await tokenRepository.clearToken();

    return null;
  }
}
