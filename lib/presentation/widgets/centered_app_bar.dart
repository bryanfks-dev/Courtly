import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';

/// [CenteredAppBar] is a custom AppBar widget that is used as the AppBar
/// for the application that contains a centered title.
class CenteredAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CenteredAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(56);

  @override

  /// [preferredSize] is the preferred size of the AppBar.
  final Size preferredSize;

  /// [title] is the custom title of the AppBar.
  final String title;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the current color scheme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return AppBar(
        titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorExt.textPrimary,
            fontFamily: "Inter"),
        centerTitle: true,
        title: Text(title));
  }
}
