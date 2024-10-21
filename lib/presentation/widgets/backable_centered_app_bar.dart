import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [BackableCenteredAppBar] is a custom AppBar widget that is used as the AppBar
/// for the application that contains a centered title and back icon.
class BackableCenteredAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BackableCenteredAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(56);

  @override

  /// [preferredSize] is the preferred size of the AppBar.
  final Size preferredSize;

  /// [title] is the custom title of the AppBar.
  final String title;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the AppColorsExtension.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return AppBar(
        leading: IconButton(
          icon: HeroIcon(HeroIcons.chevronLeft,
              size: 20, color: colorExt.highlight),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleTextStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        centerTitle: true,
        title: Text(title));
  }
}
