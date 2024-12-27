import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/payment_methods.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/domain/entities/booking.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/domain/props/payment_method_props.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/choose_payment/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [ChoosePaymentPage] is a [StatefulWidget] that displays the
/// choose payment page.
class ChoosePaymentPage extends StatefulWidget {
  const ChoosePaymentPage(
      {super.key,
      required this.paymentTotal,
      required this.bookingDate,
      required this.vendorId,
      required this.bookings});

  /// [paymentTotal] is the total amount of the payment.
  final double paymentTotal;

  /// [bookingDate] is the date of the booking.
  final String bookingDate;

  /// [vendorId] is the id of the vendor.
  final int vendorId;

  /// [bookings] is a list of [Booking] that contains the booking details.
  final Set<BookingValueProps> bookings;

  @override
  State<ChoosePaymentPage> createState() => _ChoosePaymentPage();
}

class _ChoosePaymentPage extends State<ChoosePaymentPage> {
  /// [_eWallets] is a list of [PaymentMethodProps] that contains the credit card payment methods.
  final List<PaymentMethodProps> _eWallets = [
    PaymentMethodProps(
        paymentImgSrc: "assets/images/ovo.svg.vec",
        paymentMethod: PaymentMethods.ovo,
        instructions: "Go to your OVO app and pay the amount."),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/dana.svg.vec",
        paymentMethod: PaymentMethods.dana,
        instructions: "Go to your Dana app and pay the amount."),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/gopay.svg.vec",
        paymentMethod: PaymentMethods.gopay,
        instructions: "Go to your GoPay app and pay the amount."),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/shopee_pay.svg.vec",
        paymentMethod: PaymentMethods.shopeePay,
        instructions: "Go to your Shopee Pay app and pay the amount."),
  ];

  /// [_virtualAccounts] is a list of [PaymentMethodProps] that contains the virtual account payment methods.
  final List<PaymentMethodProps> _virtualAccounts = [
    PaymentMethodProps(
        paymentImgSrc: "assets/images/bca.svg.vec",
        paymentMethod: PaymentMethods.bca,
        instructions: "Go to your BCA app and pay the amount."),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/bri.svg.vec",
        paymentMethod: PaymentMethods.bri,
        instructions: "Go to your BRI app and pay the amount."),
  ];

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an instance of [AppColorsExtension] that contains the color values.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colorExt.background,
      appBar: const BackableCenteredAppBar(title: "Choose Payment"),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: SingleChildScrollView(
            child: StickyHeader(
              header: Container(
                color: colorExt.background,
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: colorExt.outline!),
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
                        "Rp ${moneyFormatter(amount: widget.paymentTotal)}",
                        style: TextStyle(
                            color: colorExt.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    PaymentMethodsCol(
                      paymentMethods: _eWallets,
                      vendorId: widget.vendorId,
                      bookingDate: widget.bookingDate,
                      bookings: widget.bookings,
                      paymentTotal: widget.paymentTotal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PaymentMethodsCol(
                      paymentMethods: _virtualAccounts,
                      vendorId: widget.vendorId,
                      bookingDate: widget.bookingDate,
                      bookings: widget.bookings,
                      paymentTotal: widget.paymentTotal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
