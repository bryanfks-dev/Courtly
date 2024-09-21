import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';

/// NoLoggedIn is profile page content when user is not logged in.
class NoLoggedIn extends StatelessWidget {
  const NoLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Wait Uppp!",
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
                child: const Text("Let's Go!",
                    style: TextStyle(fontSize: 14, color: Colors.white)))
          ],
        ),
      ),
    ));
  }
}

/// LoggedIn is profile page content when user is logged in.
class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("You are signed in."),
      )),
    );
  }
}

/// isLoggedIn is a flag to check if user is signed in.
/// It is set to false by default.
bool isLoggedIn = false;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return const NoLoggedIn();
    }

    return const LoggedIn();
  }
}
