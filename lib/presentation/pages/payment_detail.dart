import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [PaymentDetail] is a page to show payment details.
class PaymentDetail extends StatelessWidget {
  const PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an extension of the app.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colorExt.background,
      appBar: const BackableCenteredAppBar(title: "Payment Detail"),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: PAGE_PADDING_MOBILE * 1.5),
            child: Column(
              children: [
                Text("Unggul Sport Centre Tennis Court",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorExt.textPrimary,
                    )),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                      text: "Booking ID: ",
                      style: TextStyle(color: colorExt.textPrimary),
                      children: [
                        TextSpan(
                            text: "PD12345678JCTP1",
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                HeroIcon(
                  HeroIcons.checkCircle,
                  style: HeroIconStyle.solid,
                  color: colorExt.success,
                  size: MediaQuery.of(context).size.width / 1.5,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorExt.textPrimary,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Court Type",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Tennis",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Date",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "September 21, 2024",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Time Period",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "13:00 - 15:00",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorExt.textPrimary,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Price",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Rp 30,000",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Application Service",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Rp 1,000",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1,
                        color: colorExt.outline!,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Total",
                        style: TextStyle(
                            color: colorExt.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
                )
              ],
            ),
          )),
    );
  }
}
