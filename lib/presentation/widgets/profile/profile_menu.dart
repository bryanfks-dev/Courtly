import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [ProfileMenu] is a menu item in the profile page.
class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {super.key,
      required this.iconData,
      required this.title,
      required this.onTap});

  /// [iconData] is the icon of the menu.
  final HeroIcons iconData;

  /// [title] is the title of the menu.
  final String title;

  /// [onTap] is the function to be called when the menu is tapped.
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return Container(
      color: colorExt.background,
      padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HeroIcon(iconData, color: colorExt.highlight, size: 20),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(title,
                      style:
                          TextStyle(fontSize: 14, color: colorExt.textPrimary))
                ],
              ),
              HeroIcon(
                HeroIcons.chevronRight,
                color: colorExt.highlight,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
