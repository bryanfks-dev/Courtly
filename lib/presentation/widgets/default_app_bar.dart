import 'package:flutter/material.dart';

/// DefaultAppBar is a custom AppBar widget that is used as the default AppBar
/// for the application.
/// DefaultAppBar is mainly used in home page.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key}) : preferredSize = const Size.fromHeight(56);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text("Courtly",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black)));
  }
}
