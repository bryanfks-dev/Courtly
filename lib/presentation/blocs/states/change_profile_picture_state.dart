/// [ChangeProfilePictureState] is the abstract class that will be extended by
/// the the change profile picture state.
abstract class ChangeProfilePictureState {}

/// [ChangeProfilePictureInitialState] is the initial state of the change profile
/// picture state.
/// This state will be used to initialize the change profile picture state.
class ChangeProfilePictureInitialState extends ChangeProfilePictureState {}

/// [ChangeProfilePictureLoadingState] is the loading state of the change profile
/// picture state.
/// This state will be used to show the loading state of the change profile picture
/// state.
class ChangeProfilePictureLoadingState extends ChangeProfilePictureState {}

/// [ChangeProfilePictureSuccessState] is the success state of the change profile
/// picture state.
/// This state will be used to show the success state of the change profile picture
/// state.
class ChangeProfilePictureSuccessState extends ChangeProfilePictureState {}

/// [ChangeProfilePictureErrorState] is the error state of the change profile
/// picture state.
/// This state will be used to show the error state of the change profile picture
/// state.
class ChangeProfilePictureErrorState extends ChangeProfilePictureState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  /// [ChangeProfilePictureErrorState] constructor.
  ChangeProfilePictureErrorState({required this.errorMessage});
}
