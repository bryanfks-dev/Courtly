import 'package:courtly/domain/entities/court.dart';

/// [SelectBookingState] is an abstract class that will be extended
/// by the states of the select booking bloc.
abstract class SelectBookingState {}

/// [SelectBookingInitialState] is a state of the select booking bloc.
/// This state is the initial state of the select booking bloc.
class SelectBookingInitialState extends SelectBookingState {}

/// [SelectBookingLoadingState] is a state of the select booking bloc.
/// This state is the loading state of the select booking bloc.
class SelectBookingLoadingState extends SelectBookingState {}

/// [SelectBookingLoadedState] is a state of the select booking bloc.
/// This state is the loaded state of the select booking bloc.
class SelectBookingLoadedState extends SelectBookingState {
  /// [courts] is the list of courts.
  final List<Court> courts;

  SelectBookingLoadedState({required this.courts});
}

/// [SelectBookingErrorState] is a state of the select booking bloc.
/// This state is the error state of the select booking bloc.
class SelectBookingErrorState extends SelectBookingState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  SelectBookingErrorState({required this.errorMessage});
}
