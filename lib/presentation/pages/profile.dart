import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/states/auth_state.dart';
import 'package:courtly/presentation/pages/logged_in_profile.dart';
import 'package:courtly/presentation/pages/not_logged_in_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ProfilePage] is a page to show user profile.
/// It will show different content based on user login status.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {},
        builder: (BuildContext context, AuthState state) {
          // Check the state of the auth.
          if (state is AuthenticatedState) {
            return LoggedInProfile();
          }

          return NotLoggedInProfile();
        });
  }
}
