import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/domain/usecases/court_usecase.dart';
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

  SelectBookingBloc({required this.courtUsecase, required this.orderUsecase})
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
    emit(SelectBookingFetchingState());

    // Fetch the list of courts.
    final res = await courtUsecase.getVendorCourtsUsingCourtType(
        vendorId: vendorId, courtType: courtType);

    // Handle the result.
    res.fold((l) => emit(SelectBookingErrorState(errorMessage: l.errorMessage)),
        (r) => emit(SelectBookingFetchedState(courts: r)));
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
