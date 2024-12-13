/// [RegisterState] is the abstract class that will uses to show
/// the state of the register bloc.
abstract class RegisterState {}

/// [RegisterInitialState] is the initial state of the register bloc.
/// This state is used to show the initial state of the register bloc.
class RegisterInitialState extends RegisterState {}

/// [RegisterLoadingState] is the loading state of the register bloc.
/// This state is used to show the loading state of the register bloc.
class RegisterLoadingState extends RegisterState {}

/// [RegisterSuccessState] is the success state of the register bloc.
/// This state is used to show the success state of the register bloc.
class RegisterSuccessState extends RegisterState {}

/// [RegisterErrorState] is the error state of the register bloc.
/// This state is used to show the error state of the register bloc.
class RegisterErrorState extends RegisterState {
  /// [errorMessage] is the message of the failure state.
  final dynamic errorMessage;

  RegisterErrorState({required this.errorMessage});
}
