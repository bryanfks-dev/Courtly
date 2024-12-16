import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/booking.dart';
import 'package:courtly/domain/usecases/booking_usecase.dart';
import 'package:courtly/presentation/blocs/states/booking_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BookingBloc] is the BLoC for the booking feature.
class BookingBloc extends Cubit<BookingState> {
  /// [bookingUsecase] is the usecase for the booking feature.
  final BookingUsecase bookingUsecase;

  BookingBloc({required this.bookingUsecase}) : super(BookingInitialState());

  /// [getBookings] is the method to get the bookings.
  ///
  /// Returns a [Future] of [void].
  Future<void> getBookings() async {
    emit(BookingLoadingState());

    // Get the bookings.
    final Either<Failure, List<Booking>> res =
        await bookingUsecase.getBookings();

    // Check if the result is a failure.
    res.fold((l) => emit(BookingErrorState(errorMessage: l.errorMessage)),
        (r) => emit(BookingLoadedState(bookings: r)));
  }
}
