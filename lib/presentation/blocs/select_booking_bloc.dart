import 'package:courtly/domain/usecases/court_usecase.dart';
import 'package:courtly/presentation/blocs/states/select_booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SelectBookingBloc] is a class that handles the business logic for selecting a booking.
class SelectBookingBloc extends Cubit<SelectBookingState> {
  final CourtUsecase courtUsecase;

  SelectBookingBloc({required this.courtUsecase})
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
}
