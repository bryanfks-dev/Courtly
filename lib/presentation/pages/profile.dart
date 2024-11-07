import 'package:courtly/presentation/pages/logged_in_profile.dart';
import 'package:courtly/presentation/pages/not_logged_in_profile.dart';
import 'package:courtly/presentation/bloc_providers/auth_bloc_provider.dart';
import 'package:flutter/material.dart';

/// [ProfilePage] is a page to show user profile.
/// It will show different content based on user login status.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AuthBlocProvider(
            guardedWidget: LoggedInProfile(),
            unguardedWidget: NotLoggedInProfile()));
  }
}
