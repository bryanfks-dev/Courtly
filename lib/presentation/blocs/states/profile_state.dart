import 'package:courtly/domain/entities/user.dart';

/// [ProfileState] is the abstract class that will be extended by the profile state classes.
abstract class ProfileState {}

/// [ProfileInitialState] is the initial state of the profile state.
/// This state will be used to initialize the profile state.
class ProfileInitialState extends ProfileState {}

/// [ProfileLoadingState] is the loading state of the profile state.
/// This state will be used to indicate that the profile is being loaded.
class ProfileLoadingState extends ProfileState {}

/// [ProfileLoadedState] is the loaded state of the profile state.
/// This state will be used to indicate that the profile has been loaded.
class ProfileLoadedState extends ProfileState {
  /// [user] is the user data.
  final User user;

  ProfileLoadedState({required this.user});
}

/// [ProfileErrorState] is the error state of the profile state.
/// This state will be used to indicate that an error has occurred while loading the profile.
class ProfileErrorState extends ProfileState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
}
