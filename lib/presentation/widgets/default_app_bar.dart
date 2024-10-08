import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';

/// [DefaultAppBar] is a custom AppBar widget that is used as the default AppBar
/// for the application.
/// [DefaultAppBar] is mainly used in home page.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key}) : preferredSize = const Size.fromHeight(56);

  @override

  /// [preferredSize] is the preferred size of the AppBar.
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the current color scheme.
    /// This is used to get the current color scheme of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return AppBar(
        title: Text(
      "Courtly",
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: colorExt.primary),
    ));
  }
}
