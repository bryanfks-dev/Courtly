/// [PrefsKeys] is an enum class that contains all the keys used in the shared preferences.
/// It is used to manage the keys used in the shared preferences.
enum PrefsKeys {
  introduction("introduction"),
  theme("themeMode"),
  authToken("authToken");

  /// [value] is the value of the enum.
  final String value;

  const PrefsKeys(this.value);
}
