/// Sports is an enum that contains the sports that
/// the user can choose from.
enum Sports {
  football("Football"),
  basketball("Basketball"),
  tennis("Tennis"),
  volleyball("Volleyball"),
  badminton("Badminton");

  /// label is the name of the sport.
  /// label used in the UI to show the sport name.
  final String label;

  const Sports(this.label);
}
