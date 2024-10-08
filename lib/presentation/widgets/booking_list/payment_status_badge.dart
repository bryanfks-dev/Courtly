import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/enums/payment_status.dart';
import 'package:flutter/material.dart';

/// [PaymentStatusBadge] is a widget to show the payment status within a badge.
///
/// The widget required [paymentStatus] as the status of the payment.
class PaymentStatusBadge extends StatelessWidget {
  const PaymentStatusBadge({super.key, required this.paymentStatus});

  /// [paymentStatus] is the status of the payment.
  final PaymentStatus paymentStatus;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    /// [colorMap] is the map of payment status and its color.
    final Map<PaymentStatus, Color> colorMap = {
      PaymentStatus.success: colorExt.success!,
      PaymentStatus.pending: colorExt.warning!,
      PaymentStatus.cancelled: colorExt.danger!,
    };

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: colorMap[paymentStatus]!.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorMap[paymentStatus]!)),
      child: Text(
        paymentStatus.label,
        style: TextStyle(
            color: colorMap[paymentStatus],
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
