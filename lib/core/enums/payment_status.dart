/// [PaymentStatus] is an enum class that represents the status of a payment
/// transaction.
///
/// The enum has three values: [success], [pending], and [cancelled].
enum PaymentStatus {
  success("Success"),
  pending("Pending"),
  cancelled("Cancelled");

  /// [label] is the human readable representation of the enum
  final String label;

  const PaymentStatus(this.label);
}
