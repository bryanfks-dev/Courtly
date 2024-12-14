import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/usecases/logout_usecase.dart';
import 'package:courtly/presentation/blocs/states/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [LogoutBloc] is a bloc class that contains the logout data for the app.
class LogoutBloc extends Cubit<LogoutState> {
  /// [logoutUsecase] is a usecase class that contains the logout data for the app.
  final LogoutUsecase logoutUsecase;

  LogoutBloc({required this.logoutUsecase}) : super(LogoutInitialState());

  /// [logout] is a method that logs out the user from the app.
  ///
  /// Returns a [Future] of [void].
  Future<void> logout() async {
    emit(LogoutLoadingState());

    // Logout the user
    final Failure? failure = await logoutUsecase.logout();

    // Check if the logout was successful
    if (failure != null) {
      emit(LogoutErrorState(errorMessage: failure.errorMessage));

      return;
    }

    emit(LogoutSuccessState());
  }
}
