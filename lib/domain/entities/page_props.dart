import 'package:flutter/material.dart';

/// [PageProps] is a class to store properties of a page.
///
/// [PageProps] holds the [appBar], [body], [icon], [selectedIcon], and [label]
/// of a page to shows the page identity.
class PageProps {
  /// [appBar] is the app bar of the page.
  final dynamic appBar;

  /// [body] is the body of the page.
  final Widget body;

  /// [icon] is the icon of the page in the bottom navigation bar.
  final Icon icon;

  /// [selectedIcon] is the selected icon of the page (optional) in the bottom
  /// navigation bar.
  final Icon? selectedIcon;

  /// [label] is the label of the page in the bottom navigation bar.
  final String label;

  PageProps(
      {required this.appBar,
      required this.body,
      required this.icon,
      this.selectedIcon,
      required this.label});
}
