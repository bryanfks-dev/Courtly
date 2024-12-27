/// [PaymentMethods] is an enum class that contains the payment methods.
enum PaymentMethods {
  ovo("OVO", "OVO"),
  dana("Dana", "DANA"),
  gopay("GoPay", "GOPAY"),
  shopeePay("Shopee Pay", "SHOPEE_PAY"),
  bca("BCA", "BCA"),
  bri("BRI", "BRI");

  /// [value] is the value of the enum.
  final String value;

  /// [apiValue] is the value of the enum in the API.
  final String apiValue;

  const PaymentMethods(this.value, this.apiValue);
}
