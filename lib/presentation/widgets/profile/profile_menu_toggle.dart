import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [ProfileMenuToggle] is a menu item in the profile page.
class ProfileMenuToggle extends StatelessWidget {
  const ProfileMenuToggle(
      {super.key,
      required this.iconData,
      required this.title,
      this.defaultValue = false,
      required this.onChanged});

  /// [iconData] is the icon of the menu.
  final HeroIcons iconData;

  /// [title] is the title of the menu.
  final String title;

  /// [defaultValue] is the default value of the toggle.
  final bool defaultValue;

  /// [onChanged] is the function to be called when the menu is tapped.
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return Container(
      color: colorExt.background,
      padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
                    style: TextStyle(fontSize: 14, color: colorExt.textPrimary))
              ],
            ),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: defaultValue,
                onChanged: (bool value) {
                  onChanged(value);
                },
                activeColor: colorExt.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
