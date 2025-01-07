import 'package:intl/intl.dart';

/// moneyFormatter is a function to format the amount to universal
/// currency format, but intead of comma, it will use dots as 3 digits
/// seperator.
///
/// Parameters:
///   - [amount] is the amount that will be formatted to currency format.
///
/// Returns a string of formatted amount within dots every 3 integer.
///
/// Example:
/// ```dart
/// moneyFormatter(amount: 1000000) /// "1,000,000"
/// ```
String moneyFormatter({required double amount}) {
  return NumberFormat.decimalPattern("id_ID")
      .format(amount)
      .replaceAll(".", ",");
}
