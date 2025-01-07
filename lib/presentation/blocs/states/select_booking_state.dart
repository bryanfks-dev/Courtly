import 'package:courtly/domain/entities/booking.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/domain/entities/fees.dart';

/// [SelectBookingState] is an abstract class that will be extended
/// by the states of the select booking bloc.
abstract class SelectBookingState {}

/// [SelectBookingInitialState] is a state of the select booking bloc.
/// This state is the initial state of the select booking bloc.
class SelectBookingInitialState extends SelectBookingState {}

/// [SelectBookingFetchingState] is a state of the select booking bloc.
/// This state is the fetching state of the select booking bloc.
class SelectBookingFetchingState extends SelectBookingState {}

/// [SelectBookingFetchedState] is a state of the select booking bloc.
/// This state is the fetched state of the select booking bloc.
class SelectBookingFetchedState extends SelectBookingState {
  /// [courts] is the list of courts.
  final List<Court> courts;

  /// [bookings] is the list of booking
  final List<Booking> bookings;

  /// [fees] is the fees of the booking.
  final Fees fees;

  SelectBookingFetchedState(
      {required this.courts, required this.bookings, required this.fees});
}

/// [SelectBookingSubmittingState] is a state of the select booking bloc.
/// This state is the submitting state of the select booking bloc.
class SelectBookingSubmittingState extends SelectBookingState {}

/// [SelectBookingSubmittedState] is a state of the select booking bloc.
/// This state is the submitted state of the select booking bloc.
class SelectBookingSubmittedState extends SelectBookingState {
  /// [paymentToken] is the payment token.
  final String paymentToken;

  SelectBookingSubmittedState({required this.paymentToken});
}

/// [SelectBookingErrorState] is a state of the select booking bloc.
/// This state is the error state of the select booking bloc.
class SelectBookingErrorState extends SelectBookingState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  SelectBookingErrorState({required this.errorMessage});
}
