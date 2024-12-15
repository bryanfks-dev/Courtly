import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/domain/props/payment_method_props.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/choose_payment/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ChoosePaymentPage extends StatelessWidget {
  ChoosePaymentPage({super.key});

  /// [_eWallets] is a list of [PaymentMethodProps] that contains the credit card payment methods.
  final List<PaymentMethodProps> _eWallets = [
    PaymentMethodProps(
        paymentImgSrc: "assets/images/ovo.svg.vec", paymentName: "OVO"),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/dana.svg.vec", paymentName: "Dana"),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/gopay.svg.vec", paymentName: "GoPay"),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/shopee_pay.svg.vec",
        paymentName: "Shopee Pay"),
  ];

  /// [_virtualAccounts] is a list of [PaymentMethodProps] that contains the virtual account payment methods.
  final List<PaymentMethodProps> _virtualAccounts = [
    PaymentMethodProps(
        paymentImgSrc: "assets/images/bca.svg.vec",
        paymentName: "BCA Virtual Account"),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/bni.svg.vec",
        paymentName: "BNI Virtual Account"),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/mandiri.svg.vec",
        paymentName: "Mandiri Virtual Account"),
    PaymentMethodProps(
        paymentImgSrc: "assets/images/bri.svg.vec",
        paymentName: "BRI Virtual Account"),
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
                        "Rp 31,000",
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
                    PaymentMethods(paymentMethods: _eWallets),
                    const SizedBox(
                      height: 20,
                    ),
                    PaymentMethods(paymentMethods: _virtualAccounts),
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
