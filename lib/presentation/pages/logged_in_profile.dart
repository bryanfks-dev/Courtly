import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/ranks.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu_card.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu_toggle.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [ranks] is a list of ranks available for user.
List<Ranks> ranks = Ranks.values.map((e) => e).toList();

/// [LoggedInProfile] is profile page content when user is logged in.
class LoggedInProfile extends StatefulWidget {
  const LoggedInProfile({super.key});

  @override
  State<LoggedInProfile> createState() => _LoggedInProfile();
}

class _LoggedInProfile extends State<LoggedInProfile> {
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

  /// [_isDarkMode] is the state of the dark mode toggle.
  bool _isDarkMode = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return SafeArea(
        child: ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: PAGE_PADDING_MOBILE,
              right: PAGE_PADDING_MOBILE,
              bottom: 20),
          color: colorExt.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(999)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("John Doe",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Change Pic",
                                style: TextStyle(
                                    color: colorExt.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: colorExt.primary,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Text(_rank.label,
                            style: TextStyle(
                                color: _rank.color,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _rank.color, shape: BoxShape.circle),
                    child: Text("1", style: TextStyle(color: Colors.white)),
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
                      const Positioned(
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _nextRank.color, shape: BoxShape.circle),
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ProfileMenuCard(title: "Personal Information", menus: [
          ProfileMenu(
              iconData: HeroIcons.atSymbol,
              title: "Change Username",
              onTap: () {}),
          ProfileMenu(
              iconData: HeroIcons.lockClosed,
              title: "Change Password",
              onTap: () {}),
        ]),
        const SizedBox(
          height: 10,
        ),
        ProfileMenuCard(title: "Preference", menus: [
          ProfileMenuToggle(
              iconData: HeroIcons.moon,
              title: "Dark Mode",
              defaultValue: _isDarkMode,
              onChanged: _toggleDarkMode),
        ]),
        const SizedBox(
          height: 10,
        ),
        ProfileMenu(
            iconData: HeroIcons.arrowRightStartOnRectangle,
            title: "Log Out",
            onTap: () {})
      ],
    ));
  }
}
