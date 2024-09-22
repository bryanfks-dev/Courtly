import 'package:flutter/material.dart';

/// PageProps is a class to store properties of a page.
///
/// [appBar] is the app bar of the page.
/// [body] is the body of the page.
/// [icon] is the icon of the page.
/// [selectedIcon] is the selected icon of the page.
/// [label] is the label of the page.
class PageProps {
  /// appBar is the app bar of the page.
  final dynamic appBar;

  /// body is the body of the page.
  final Widget body;

  /// icon is the icon of the page.
  final Icon icon;

  /// selectedIcon is the selected icon of the page (optional).
  final Icon? selectedIcon;

  /// label is the label of the page.
  final String label;

  PageProps(
      {required this.appBar,
      required this.body,
      required this.icon,
      this.selectedIcon,
      required this.label});
}
