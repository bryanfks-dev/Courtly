import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/domain/entities/user.dart';

/// [HomeState] is the abstract class that will be extended by the different states of the HomeBloc.
abstract class HomeState {}

/// [HomeInitialState] is the initial state of the HomeBloc.
/// This state will be used when the HomeBloc is initialized.
class HomeInitialState extends HomeState {}

/// [HomeLoadingState] is the loading state of the HomeBloc.
/// This state will be used when the HomeBloc is loading data.
class HomeLoadingState extends HomeState {}

/// [HomeLoadedState] is the loaded state of the HomeBloc.
/// This state will be used when the HomeBloc has loaded data.
class HomeLoadedState extends HomeState {
  /// [user] is the user data.
  final User? user;

  /// [courts] is the list of courts.
  final List<Court> courts;

  HomeLoadedState({
    this.user,
    required this.courts,
  });
}

/// [HomeErrorState] is the error state of the HomeBloc.
/// This state will be used when the HomeBloc has encountered an error.
class HomeErrorState extends HomeState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  HomeErrorState({
    required this.errorMessage,
  });
}
