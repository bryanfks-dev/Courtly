import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/domain/usecases/booking_usecase.dart';
import 'package:courtly/domain/usecases/court_usecase.dart';
import 'package:courtly/presentation/blocs/states/select_booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SelectBookingBloc] is a class that handles the business logic for selecting a booking.
class SelectBookingBloc extends Cubit<SelectBookingState> {
  /// [courtUsecase] is the usecase to handle court related operations.
  final CourtUsecase courtUsecase;

  /// [bookingUsecase] is the usecase to handle booking related operations.
  final BookingUsecase bookingUsecase;

  SelectBookingBloc({required this.courtUsecase, required this.bookingUsecase})
      : super(SelectBookingInitialState());

  /// [getCourts] is a method that fetches the list of courts.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [courtType] is the type of court.
  ///
  /// Returns a [Future] of [void]
  Future<void> getCourts(
      {required int vendorId, required String courtType}) async {
    emit(SelectBookingLoadingState());

    // Fetch the list of courts.
    final res = await courtUsecase.getVendorCourtsUsingCourtType(
        vendorId: vendorId, courtType: courtType);

    // Handle the result.
    res.fold((l) => emit(SelectBookingErrorState(errorMessage: l.errorMessage)),
        (r) => emit(SelectBookingLoadedState(courts: r)));
  }

  /// [createBookings] is the method to create bookings.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [date] is the date of the booking.
  ///   - [bookingDatas] is the data of the booking.
  ///
  /// Returns a [Future] of [void].
  Future<void> createBookings(
      {required int vendorId,
      required String date,
      required Set<BookingValueProps> bookingDatas}) async {
    emit(SelectBookingLoadingState());

    // Create the bookings.
    final Failure? res = await bookingUsecase.createBookings(
        vendorId: vendorId, date: date, bookingDatas: bookingDatas);

    // Check if the result is a failure.
    if (res != null) {
      emit(CreateBookingErrorState(errorMessage: res.errorMessage));

      return;
    }

    emit(BookingCreatedState());
  }
}
