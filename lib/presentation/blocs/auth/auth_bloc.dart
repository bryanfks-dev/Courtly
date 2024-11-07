import 'package:courtly/data/repository/token_repository.dart';
import 'package:courtly/presentation/blocs/auth/auth_event.dart';
import 'package:courtly/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AuthBloc] is a BLoC to manage user authentication.
/// It will check if user is authenticated or not.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// [tokenRepository] is a repository to get user token.
  final TokenRepository tokenRepository;

  AuthBloc({required this.tokenRepository}) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLoginAuth);
  }

  Future<void> _onLoginAuth(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    // Get token from repository.
    final String? token = await tokenRepository.getToken();

    // Check if token is not null or empty.
    if (token != null && token.isNotEmpty) {
      emit(AuthAuthenticated());

      return;
    }

    emit(AuthUnauthenticated());
  }
}
