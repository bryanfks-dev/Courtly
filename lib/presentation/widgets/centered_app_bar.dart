import 'package:flutter/material.dart';

/// CenteredAppBar is a custom AppBar widget that is used as the AppBar
/// for the application that contains a centered title.
class CenteredAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CenteredAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(56);

  @override
  final Size preferredSize;

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleTextStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        centerTitle: true,
        title: Text(title));
  }
}
