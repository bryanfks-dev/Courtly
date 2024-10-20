import 'package:courtly/presentation/pages/logged_in_profile.dart';
import 'package:courtly/presentation/pages/not_logged_in_profile.dart';
import 'package:flutter/material.dart';

/// [ProfilePage] is a page to show user profile.
/// It will show different content based on user login status.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  /// [isLoggedIn] is a flag to check if user is signed in.
  /// It is set to false by default.
  bool _isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    // Render content based on user login status.
    if (!_isLoggedIn) {
      return const NotLoggedInProfile();
    }

    return const LoggedInProfile();
  }
}
