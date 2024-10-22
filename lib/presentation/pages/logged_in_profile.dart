import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/ranks.dart';
import 'package:courtly/presentation/providers/theme_provider.dart';
import 'package:courtly/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu_card.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu_toggle.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

/// [ranks] is a list of ranks available for user.
List<Ranks> ranks = Ranks.values.map((e) => e).toList();

/// [LoggedInProfile] is profile page content when user is logged in.
class LoggedInProfile extends StatelessWidget {
  const LoggedInProfile({super.key});

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
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    /// [themeProvider] is the provider of the theme of the application.
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    /// [darkMode] is the notifier for the dark mode.
    final ValueNotifier<bool> darkMode =
        ValueNotifier(themeProvider.currentTheme == AppThemes.dark);

    /// [toggleDarkMode] is the function to toggle the dark mode.
    ///
    /// - Parameters:
    ///   - [value] is the value of the toggle.
    ///
    /// - Returns: void.
    void toggleDarkMode(bool value) {
      if (value) {
        themeProvider.setDarkTheme();
      } else {
        themeProvider.setLightTheme();
      }

      darkMode.value = value;
    }

    /// [openLogoutModal] is the function to open the logout modal.
    /// This function will open the modal to confirm the logout action.
    ///
    /// - Returns: void.
    void openLogoutModal() {
      // Open the logout modal.
      showBottomModalSheet(
          context,
          Column(
            children: [
              Text.rich(
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorExt.textPrimary),
                  TextSpan(text: "You are about to ", children: [
                    TextSpan(
                        text: "log out",
                        style: TextStyle(color: colorExt.danger)),
                    const TextSpan(text: ", confirm to proceed.")
                  ])),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                              BorderSide(width: 1, color: colorExt.highlight!)),
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(0))),
                      child: Text(
                        "I changed my mind",
                        style: TextStyle(
                            color: colorExt.highlight,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(colorExt.danger),
                          minimumSize: WidgetStateProperty.all(
                              const Size.fromHeight(0))),
                      child: const Text("Log me out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)))
                ],
              )
            ],
          ));
    }

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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(999)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("John Doe",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(_rank.label,
                          style: TextStyle(
                              color: _rank.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
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
                        minHeight: 6,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      const Positioned(
                          left: 0,
                          top: 10,
                          child: Text(
                            "EXP 700/1000",
                            style: TextStyle(fontSize: 10),
                          )),
                      const Positioned(
                          right: 0,
                          top: 10,
                          child: Text(
                            "Elite Rank",
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
              defaultValue: darkMode.value,
              onChanged: toggleDarkMode),
        ]),
        const SizedBox(
          height: 10,
        ),
        ProfileMenu(
            iconData: HeroIcons.arrowRightStartOnRectangle,
            title: "Log Out",
            onTap: openLogoutModal)
      ],
    ));
  }
}
