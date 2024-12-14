/// [LogoutState] is the abstract class that will be extended by the
/// logout state classes.
abstract class LogoutState {}

/// [LogoutInitialState] is the initial state of the logout bloc.
/// This state is the state before any event is triggered.
class LogoutInitialState extends LogoutState {}

/// [LogoutLoadingState] is the state of the logout bloc when the user
/// is logging out.
/// This state is triggered when the user is logging out.
class LogoutLoadingState extends LogoutState {}

/// [LogoutSuccessState] is the state of the logout bloc when the user
/// has successfully logged out.
/// This state is triggered when the user has successfully logged out.
class LogoutSuccessState extends LogoutState {}

/// [LogoutErrorState] is the state of the logout bloc when the user
/// has failed to log out.
/// This state is triggered when the user has failed to log out.
class LogoutErrorState extends LogoutState {
  /// [errorMessage] is the error message that will be displayed to the user.
  final String errorMessage;

  LogoutErrorState({required this.errorMessage});
}
