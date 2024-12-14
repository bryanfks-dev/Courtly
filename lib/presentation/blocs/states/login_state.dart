/// [LoginState] is the abstract class that will be extended by the different
/// states of the login bloc.
abstract class LoginState {}

/// [LoginInitialState] is the initial state of the login bloc.
/// It will be used to show the initial state of the login screen.
class LoginInitialState extends LoginState {}

/// [LoginLoadingState] is the loading state of the login bloc.
/// It will be used to show the loading state of the login screen.
class LoginLoadingState extends LoginState {}

/// [LoginSuccessState] is the success state of the login bloc.
/// It will be used to show the success state of the login screen.
class LoginSuccessState extends LoginState {}

/// [LoginErrorState] is the failure state of the login bloc.
/// It will be used to show the failure state of the login screen.
class LoginErrorState extends LoginState {
  /// [errorMessage] is the message that will be shown in the login screen.
  final dynamic errorMessage;

  LoginErrorState({required this.errorMessage});
}
