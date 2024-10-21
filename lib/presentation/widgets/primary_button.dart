import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';

/// [PrimaryButton] is a primary button used in the app.
/// It is a custom button with red background color.
///
/// [PrimaryButton] takes [child] to display and [onPressed] function to be
/// called when button is pressed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.style,
    required this.onPressed,
    required this.child,
  });

  /// [style] is the style of the button.
  final ButtonStyle? style;

  /// [onPressed] is the function to be called when button is pressed.
  final VoidCallback onPressed;

  /// [child] is the widget to be displayed inside the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              padding: style?.padding?.resolve({}) ??
                  const EdgeInsets.symmetric(vertical: 12),
              shape: style?.shape?.resolve({}) ??
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
              backgroundColor:
                  style?.backgroundColor?.resolve({}) ?? colorExt.primary,
              foregroundColor: Colors.white)
          .merge(style),
      onPressed: onPressed,
      child: child,
    );
  }
}
