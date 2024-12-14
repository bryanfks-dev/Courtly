import 'package:courtly/domain/usecases/auth_usecase.dart';
import 'package:courtly/presentation/blocs/events/auth_event.dart';
import 'package:courtly/presentation/blocs/states/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AuthBloc] is the bloc for authentication.
/// This bloc will handle the authentication process.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// [authUsecase] is the usecase for authentication.
  final AuthUsecase authUsecase;

  AuthBloc({required this.authUsecase}) : super(AuthInitialState()) {
    on<CheckAuthEvent>(_onCheckAuthEvent);
  }

  /// [_onCheckAuthEvent] is a function to handle the [CheckAuthEvent].
  ///
  /// Parameters:
  ///   - [event] is the event.
  ///   - [emit] is the emitter.
  ///
  /// Returns: void
  Future<void> _onCheckAuthEvent(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    // Execute the auth usecase
    final bool tokenAvailable = await authUsecase.tokenAvailable();

    // Check if the token is not available
    if (!tokenAvailable) {
      emit(UnauthenticatedState());

      return;
    }

    emit(AuthenticatedState());
  }
}
