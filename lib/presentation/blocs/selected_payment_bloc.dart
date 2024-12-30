import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/domain/usecases/order_usecase.dart';
import 'package:courtly/presentation/blocs/states/selected_payment_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SelectedPaymentBloc] is a [Cubit] that manages the selected payment
/// state and page.
class SelectedPaymentBloc extends Cubit<SelectedPaymentState> {
  /// [orderUsecase] is the instance of the [OrderUsecase].
  final OrderUsecase orderUsecase;

  SelectedPaymentBloc({required this.orderUsecase})
      : super(SelectedPaymentInitialState());

  /// [submitBookingPayment] is a method to submit the booking payment.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [date] is the date of the booking.
  ///   - [paymentMethodApiValue] is the payment method.
  ///   - [bookingDatas] is the set of booking data.
  ///
  /// Returns a [Future] of [void]
  Future<void> submitBookingPayment({
    required int vendorId,
    required String date,
    required String paymentMethodApiValue,
    required Set<BookingValueProps> bookingDatas,
  }) async {
    emit(SelectedPaymentLoadingState());

    // Submit the booking payment.
    final Either<Failure, String> res = await orderUsecase.createOrder(
        vendorId: vendorId,
        date: date,
        bookingDatas: bookingDatas);

    res.fold(
        (l) => emit(SelectedPaymentErrorState(errorMessage: l.errorMessage)),
        (r) => emit(SelectedPaymentSuccessState(paymentToken: r)));
  }
}
