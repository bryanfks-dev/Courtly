import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

/// [NoLoggedIn] is profile page content when user is not logged in.
class NoLoggedIn extends StatelessWidget {
  const NoLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgPicture(AssetBytesLoader("assets/images/wait_up.svg.vec"),
              height: 200),
          const Text(
            "Wait Upp!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Column(
            children: [
              Text(
                "Hold on! You are not logged in yet.",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Login here.",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
              onPressed: () {
                // Navigate to login page.
                Navigator.pushNamed(context, Routes.login);
              },
              child: const Text("Let's Login!",
                  style: TextStyle(fontSize: 14, color: Colors.white)))
        ],
      ),
    ));
  }
}

/// [LoggedIn] is profile page content when user is logged in.
class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
      child: Text("You are signed in."),
    ));
  }
}

/// [isLoggedIn] is a flag to check if user is signed in.
/// It is set to false by default.
bool isLoggedIn = false;

/// [ProfilePage] is a page to show user profile.
/// It will show different content based on user login status.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Render content based on user login status.
    if (!isLoggedIn) {
      return const NoLoggedIn();
    }

    return const LoggedIn();
  }
}
