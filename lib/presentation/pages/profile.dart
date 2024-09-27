import 'package:courtly/core/enums/ranks.dart';
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
      minimum: const EdgeInsets.only(left: 15, right: 15),
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
    );
  }
}

/// [ranks] is a list of ranks available for user.
List<Ranks> ranks = Ranks.values.map((e) => e).toList();

/// [LoggedIn] is profile page content when user is logged in.
class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

  final Ranks _rank = Ranks.veteran;

  /// [_nextRank] is the next rank of the user.
  Ranks get _nextRank {
    // Get the index of the current rank.
    final int index = ranks.indexOf(_rank);

    // If the current rank is the last rank, return the current rank.
    if (index == ranks.length - 1) {
      return _rank;
    }

    return ranks[index + 1];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("John Doe", style: TextStyle(fontSize: 20)),
                  Text(_rank.label,
                      style: TextStyle(
                          color: _rank.color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    child: Text("1", style: TextStyle(color: Colors.white)),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _rank.color, shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      LinearProgressIndicator(
                        value: 0.7,
                        valueColor: AlwaysStoppedAnimation<Color>(_rank.color),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      Positioned(
                          left: 0,
                          top: 7,
                          child: Text(
                            "EXP 700/1000",
                            style: TextStyle(fontSize: 10),
                          ))
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _nextRank.color, shape: BoxShape.circle),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Data",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Change Password", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey.shade600, size: 12)
                  ],
                ),
              )
            ],
          ),
        )
      ],
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
