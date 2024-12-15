/// [PaymentMethodProps] is a class that holds the properties of a payment method.
/// This class is used to display the payment method in the payment menu.
class PaymentMethodProps {
  /// [paymentImgSrc] is the image source of the payment method.
  final String paymentImgSrc;

  /// [paymentName] is the name of the payment method.
  final String paymentName;

  PaymentMethodProps({
    required this.paymentImgSrc,
    required this.paymentName,
  });
}
