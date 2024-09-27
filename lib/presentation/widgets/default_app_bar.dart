import 'package:courtly/core/constants/color_schemes.dart';
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
    return AppBar(
        title: Text(
      "Courtly",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    ));
  }
}
