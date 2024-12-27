import 'package:courtly/core/enums/payment_methods.dart';

/// [PaymentMethodProps] is a class that holds the properties of a payment method.
/// This class is used to display the payment method in the payment menu.
class PaymentMethodProps {
  /// [paymentImgSrc] is the image source of the payment method.
  final String paymentImgSrc;

  /// [paymentMethod] is the payment method.
  final PaymentMethods paymentMethod;

  /// [instructions] is the instructions for the payment method.
  final String instructions;

  PaymentMethodProps({
    required this.paymentImgSrc,
    required this.paymentMethod,
    required this.instructions,
  });
}
