import 'package:courtly/domain/entities/booking.dart';

/// [BookingState] is the abstract class that will be extended by the different states of the booking bloc.
abstract class BookingState {}

/// [BookingInitialState] is the initial state of the booking bloc.
/// This state will be used when the booking bloc is initialized.
class BookingInitialState extends BookingState {}

/// [BookingLoadingState] is the loading state of the booking bloc.
/// This state will be used when the booking bloc is loading data.
class BookingLoadingState extends BookingState {}

/// [BookingLoadedState] is the loaded state of the booking bloc.
/// This state will be used when the booking bloc has loaded data.
class BookingLoadedState extends BookingState {
  /// [bookings] is the list of bookings.
  final List<Booking> bookings;

  BookingLoadedState({
    required this.bookings,
  });
}

/// [BookingErrorState] is the error state of the booking bloc.
/// This state will be used when the booking bloc has encountered 
/// an error.
class BookingErrorState extends BookingState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  BookingErrorState({
    required this.errorMessage,
  });
}
