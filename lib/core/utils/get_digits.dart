/// getDigits is a function that returns the number of digits in a number.
/// 
/// Parameters:
///   - [number] is the number that will be counted the digits.
/// 
/// Returns an integer of the number of digits in the number.
/// 
/// Example:
/// ```dart
/// getDigits(number: 123); // 3
/// ```
int getDigits({required int number}) {
  return number.toString().length;
}
