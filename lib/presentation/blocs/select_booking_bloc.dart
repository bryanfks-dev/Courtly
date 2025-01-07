import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/domain/usecases/court_usecase.dart';
import 'package:courtly/domain/usecases/fees_usecase.dart';
import 'package:courtly/domain/usecases/order_usecase.dart';
import 'package:courtly/presentation/blocs/states/select_booking_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SelectBookingBloc] is a class that handles the business logic for selecting a booking.
class SelectBookingBloc extends Cubit<SelectBookingState> {
  /// [courtUsecase] is an instance of the [CourtUsecase] class.
  final CourtUsecase courtUsecase;

  /// [orderUsecase] is an instance of the [OrderUsecase] class.
  final OrderUsecase orderUsecase;

  /// [feesUsecase] is an instance of the [FeesUsecase] class.
  final FeesUsecase feesUsecase;

  SelectBookingBloc(
      {required this.courtUsecase,
      required this.orderUsecase,
      required this.feesUsecase})
      : super(SelectBookingInitialState());

  /// [getCourts] is a method that fetches the list of courts.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [courtType] is the type of court.
  ///   - [date] is the date of the booking.
  ///
  /// Returns a [Future] of [void]
  Future<void> getCourts(
      {required int vendorId,
      required String courtType,
      required DateTime date}) async {
    emit(SelectBookingFetchingState());

    // Fetch the list of courts and list of court bookings.
    final List<Either> res = await Future.wait([
      courtUsecase.getVendorCourtsUsingCourtType(
          vendorId: vendorId, courtType: courtType),
      courtUsecase.getCourtBookings(
          vendorId: vendorId, courtType: courtType, date: date),
      feesUsecase.getFees(),
    ]);

    // Check for failure
    if (res[0].isLeft()) {
      res[0].fold(
          (l) => emit(SelectBookingErrorState(errorMessage: l.errorMessage)),
          (r) => emit(SelectBookingErrorState(errorMessage: "Unknown Error")));

      return;
    }

    if (res[1].isLeft()) {
      res[1].fold(
          (l) => emit(SelectBookingErrorState(errorMessage: l.errorMessage)),
          (r) => emit(SelectBookingErrorState(errorMessage: "Unknown Error")));

      return;
    }

    if (res[2].isLeft()) {
      res[2].fold(
          (l) => emit(SelectBookingErrorState(errorMessage: l.errorMessage)),
          (r) => emit(SelectBookingErrorState(errorMessage: "Unknown Error")));

      return;
    }

    emit(SelectBookingFetchedState(
        courts: res[0].getOrElse(() => throw 'No Courts Response'),
        bookings: res[1].getOrElse(() => throw 'No Court Bookings Response'),
        fees: res[2].getOrElse(() => throw 'No Fees Response')));
  }

  Future<void> submitBooking({
    required int vendorId,
    required String date,
    required Set<BookingValueProps> bookingDatas,
  }) async {
    emit(SelectBookingSubmittingState());

    // Submit the booking.
    final Either<Failure, String> res = await orderUsecase.createOrder(
        vendorId: vendorId, date: date, bookingDatas: bookingDatas);

    // Handle the result.
    res.fold((l) => emit(SelectBookingErrorState(errorMessage: l.errorMessage)),
        (r) => emit(SelectBookingSubmittedState(paymentToken: r)));
  }
}
