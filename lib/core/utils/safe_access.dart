/// listSafeAccess is a utility function that is used to safely access the elements of a list.
///
/// Parameters:
///   - [list] is the list to be accessed.
///   - [index] is the index of the element to be accessed.
///   - [defaultValue] is the default value to be returned if the index is out of bounds.
///
/// Returns a value of type T.
/// 
/// Example:
/// ```dart
/// listSafeAccess(list: [1, 2, 3], index: 2, defaultValue: 0); // 3
/// listSafeAccess(list: [1, 2, 3], index: 3, defaultValue: 0); // 0
/// ```
T listSafeAccess<T>(
    {required List<T> list, required int index, required T defaultValue}) {
  // The try-catch block is used to catch the RangeError exception.
  try {
    return list[index];
  } on RangeError catch (_) {
    return defaultValue;
  } catch (_) {
    rethrow;
  }
}
