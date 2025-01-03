import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/usecases/login_usecase.dart';
import 'package:courtly/presentation/blocs/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [LoginBloc] is a cubit class that manages the login state.
class LoginBloc extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginInitialState());

  /// [login] method is used to login the user.
  ///
  /// Parameters:
  ///   - [username] is a string that holds the username.
  ///   - [password] is a string that holds the password.
  ///
  /// Returns a [void].
  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoadingState());

    // Call the login usecase
    final Failure? result =
        await loginUsecase.login(username: username, password: password);

    // Check for failure
    if (result != null) {
      emit(LoginErrorState(errorMessage: result.errorMessage));

      return;
    }

    emit(LoginSuccessState());
  }
}
