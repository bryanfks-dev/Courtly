/// [AuthState] is the abstract class that will be extended by the
/// different states of the authentication bloc.
abstract class AuthState {}

/// [AuthInitial] is the initial state of the authentication bloc.
class AuthInitial extends AuthState {}

/// [AuthLoading] is the state of the authentication bloc when the
class AuthLoading extends AuthState {}

/// [AuthAuthenticated] is the state of the authentication bloc when the
class AuthAuthenticated extends AuthState {}

/// [AuthUnauthenticated] is the state of the authentication bloc when the
class AuthUnauthenticated extends AuthState {}
