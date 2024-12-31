/// [PaymentStatus] is an enum class that represents the status of a payment
/// transaction.
///
/// The enum has three values: [success] and [pending].
enum PaymentStatus {
  success("Success"),
  pending("Pending"),
  canceled("Canceled");

  /// [label] is the human readable representation of the enum
  final String label;

  const PaymentStatus(this.label);
}
