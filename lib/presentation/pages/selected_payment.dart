import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/domain/props/payment_method_props.dart';
import 'package:courtly/presentation/blocs/selected_payment_bloc.dart';
import 'package:courtly/presentation/blocs/states/selected_payment_state.dart';
import 'package:courtly/presentation/providers/midtrans_provider.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

/// [SelectedPaymentPage] is a [StatelessWidget] that displays the selected
/// payment method.
class SelectedPaymentPage extends StatelessWidget {
  const SelectedPaymentPage(
      {super.key,
      required this.paymentMethod,
      required this.paymentTotal,
      required this.vendorId,
      required this.bookingDate,
      required this.bookings});

  /// [paymentMethod] is the payment method.
  final PaymentMethodProps paymentMethod;

  /// [bookingDate] is the date of the booking.
  final String bookingDate;

  /// [vendorId] is the id of the vendor.
  final int vendorId;

  /// [bookings] is a list of [Booking] that contains the booking details.
  final Set<BookingValueProps> bookings;

  /// [paymentTotal] is the total amount of the payment.
  final double paymentTotal;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an instance of [AppColorsExtension] that contains the
    /// color values.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
        backgroundColor: colorExt.background,
        appBar:
            BackableCenteredAppBar(title: paymentMethod.paymentMethod.value),
        body: SafeArea(
          child: BlocConsumer<SelectedPaymentBloc, SelectedPaymentState>(
              listener: (BuildContext context, SelectedPaymentState state) {
            // Check the state of the selected payment.
            if (state is SelectedPaymentErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }

            if (state is SelectedPaymentSuccessState) {
              // Start the payment.
              MidtransProvider.startPayment(paymentToken: state.paymentToken);
            }
          }, builder: (BuildContext context, SelectedPaymentState state) {
            // Check the state of the selected payment.
            if (state is SelectedPaymentLoadingState) {
              return LoadingScreen();
            }

            return Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PAGE_PADDING_MOBILE),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: colorExt.outline!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Total",
                                style: TextStyle(
                                    color: colorExt.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Rp ${moneyFormatter(amount: paymentTotal)}",
                                style: TextStyle(
                                    color: colorExt.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 152,
                            height: 152,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SvgPicture(
                              AssetBytesLoader(paymentMethod.paymentImgSrc),
                              semanticsLabel: paymentMethod.paymentMethod.value,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Instructions",
                                style: TextStyle(
                                    color: colorExt.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Text(paymentMethod.instructions,
                                style: TextStyle(
                                  color: colorExt.textPrimary,
                                  fontSize: 14,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PAGE_PADDING_MOBILE, vertical: 20),
                  decoration: BoxDecoration(
                    color: colorExt.background,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    border: Border.all(color: colorExt.outline!),
                  ),
                  child: PrimaryButton(
                      onPressed: () {
                        context
                            .read<SelectedPaymentBloc>()
                            .submitBookingPayment(
                                vendorId: 1,
                                date: bookingDate,
                                paymentMethodApiValue:
                                    paymentMethod.paymentMethod.apiValue,
                                bookingDatas: bookings);
                      },
                      style: ButtonStyle(
                          minimumSize:
                              WidgetStatePropertyAll(Size.fromHeight(0))),
                      child: Text(
                        "Pay with ${paymentMethod.paymentMethod.value}",
                        style: TextStyle(color: colorExt.background),
                      )),
                )
              ],
            );
          }),
        ));
  }
}
