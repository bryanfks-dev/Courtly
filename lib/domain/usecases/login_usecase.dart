import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/login_form_dto.dart';
import 'package:courtly/data/repository/api/login_repository.dart';
import 'package:courtly/data/repository/local/token_repository.dart';

/// [LoginUsecase] class is a usecase class that handles
/// the login data from the server
class LoginUsecase {
  /// [loginRepository] is an instance of [LoginRepository] class
  final LoginRepository loginRepository;

  /// [tokenRepository] is an instance of [TokenRepository] class
  final TokenRepository tokenRepository;

  LoginUsecase({required this.loginRepository, required this.tokenRepository});

  /// [login] method is used to post login data to the server
  /// and set the token in the shared preferences.
  ///
  /// Parameters:
  ///   - [formDto] is an instance of [LoginFormDTO] class
  ///
  /// Returns a [Future] of [Failure] or [null]
  Future<Failure?> login(
      {required String username, required String password}) async {
    // Create a [LoginFormDTO] object
    final LoginFormDTO formDto =
        LoginFormDTO(username: username, password: password);

    // Post login data to the server
    final result = await loginRepository.postLogin(formDto: formDto);

    // Check for failure
    return result.fold(
      (l) => l,
      (r) async {
        await tokenRepository.setToken(r.token);

        return null;
      },
    );
  }
}
