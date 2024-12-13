/// AuthState is the base class for all states in the AuthBloc.
abstract class AuthState {}

/// AuthInitialState is the initial state for the AuthBloc.
class AuthInitialState extends AuthState {}

/// AuthenticatingState is the authenticating state for the AuthBloc.
class AuthenticatedState extends AuthState {}

/// UnauthenticatedState is the unauthenticated state for the AuthBloc.
class UnauthenticatedState extends AuthState {}
