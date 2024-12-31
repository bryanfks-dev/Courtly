import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/payment_status.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/domain/entities/order.dart';
import 'package:courtly/presentation/pages/order_detail.dart';
import 'package:courtly/presentation/pages/write_review.dart';
import 'package:courtly/presentation/providers/midtrans_provider.dart';
import 'package:courtly/presentation/widgets/orders/payment_status_badge.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [PurchaseCard] is a widget to show the purchase card.
class PurchaseCard extends StatelessWidget {
  const PurchaseCard({super.key, required this.order});

  /// [order] is the order entity.
  final Order order;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return InkWell(
      onTap: () {
        // Check for the order status
        if (order.status == PaymentStatus.canceled.label) {
          return;
        }

        if (order.status == PaymentStatus.pending.label) {
          MidtransProvider.startPayment(paymentToken: order.paymentToken);

          return;
        }

        // Navigate to order detail page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    OrderDetailPage(orderId: order.id)));
      },
      child: Container(
        color: colorExt.background,
        padding: const EdgeInsets.all(PAGE_PADDING_MOBILE),
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
                    Text(DateFormat("MMM, dd yyyy").format(order.date),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorExt.highlight)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order.courtType} Court",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          order.vendor.name,
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                PaymentStatusBadge(paymentStatus: order.status)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rp ${moneyFormatter(amount: order.price + order.appFee)}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                if (order.status == PaymentStatus.success.label) ...[
                  Row(
                    children: [
                      if (!order.reviewed!) ...[
                        SecondaryButton(
                            onPressed: () {
                              // Navigate to write review page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WriteReviewPage(
                                            order: order,
                                          )));
                            },
                            style: const ButtonStyle(
                              visualDensity: VisualDensity.compact,
                            ),
                            child: const Text("Rate")),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                      PrimaryButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              visualDensity: VisualDensity.compact,
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 10))),
                          child: const Text("Rebook"))
                    ],
                  )
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
