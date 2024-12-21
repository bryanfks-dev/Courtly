/// [ChangeUsernameState] is a abstract class which is used to represent different states of change username bloc.
abstract class ChangeUsernameState {}

/// [ChangeUsernameInitialState] is a class which is used to represent initial state of change username bloc.
/// This state is used to represent the initial state of change username bloc.
class ChangeUsernameInitialState extends ChangeUsernameState {}

/// [ChangeUsernameLoadingState] is a class which is used to represent loading state of change username bloc.
/// This state is used to represent the loading state of change username bloc.
class ChangeUsernameLoadingState extends ChangeUsernameState {}

/// [ChangeUsernameSuccessState] is a class which is used to represent success state of change username bloc.
/// This state is used to represent the success state of change username bloc.
class ChangeUsernameSuccessState extends ChangeUsernameState {}

/// [ChangeUsernameErrorState] is a class which is used to represent error state of change username bloc.
/// This state is used to represent the error state of change username bloc.
class ChangeUsernameErrorState extends ChangeUsernameState {
  /// [errorMessage] is the error message.
  final dynamic errorMessage;

  ChangeUsernameErrorState({required this.errorMessage});
}
