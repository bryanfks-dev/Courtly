/// [TeamMemberProps] is a class that holds properties of a team member.
/// This class is used to display the team member in the about us page.
class TeamMemberProps {
  /// [imagePath] is the path to member image or photo.
  final String imagePath;

  /// [name] is the name of the team member.
  final String name;

  /// [role] is the role of the team member.
  final String role;

  TeamMemberProps({
    required this.imagePath,
    required this.name,
    required this.role,
  });
}
