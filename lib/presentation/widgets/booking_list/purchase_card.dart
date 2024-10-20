import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/payment_status.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/presentation/widgets/booking_list/payment_status_badge.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [PurchaseCard] is a widget to show the purchase card.
/// [PurchaseCard] shows the [purchaseDate], [sportType], [vendorName],
/// [price], and [paymentStatus] of the payment.
class PurchaseCard extends StatelessWidget {
  const PurchaseCard(
      {super.key,
      required this.purchaseDate,
      required this.sportType,
      required this.vendorName,
      required this.price,
      required this.paymentStatus});

  /// [purchaseDate] is the date of the purchase.
  final DateTime purchaseDate;

  /// [sportType] is the type of the sport.
  final Sports sportType;

  /// [vendorName] is the name of the vendor.
  final String vendorName;

  /// [price] is the price of the purchase.
  final int price;

  /// [paymentStatus] is the status of the payment.
  final PaymentStatus paymentStatus;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return GestureDetector(
      child: Container(
        color: colorExt.background,
        padding: const EdgeInsets.symmetric(
            horizontal: PAGE_PADDING_MOBILE, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        DateFormat("MMM, dd yyyy", "en_US")
                            .format(purchaseDate),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorExt.highlight)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${sportType.label} Court",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          vendorName,
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                PaymentStatusBadge(paymentStatus: paymentStatus)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rp ${moneyFormatter(amount: price)}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    SecondaryButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text(
                          "Rate",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    PrimaryButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            visualDensity: VisualDensity.compact,
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 10))),
                        child: const Text(
                          "Rebook",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
