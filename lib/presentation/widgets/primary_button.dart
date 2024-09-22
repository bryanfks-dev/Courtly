import 'package:flutter/material.dart';

/// [PrimaryButton] is a primary button used in the app.
/// It is a custom button with red background color.
///
/// [PrimaryButton] takes [child] to display and [onPressed] function to be
/// called when button is pressed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  /// [onPressed] is the function to be called when button is pressed.
  final VoidCallback onPressed;

  /// [child] is the widget to be displayed inside the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(0),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.red),
      onPressed: onPressed,
      child: child,
    );
  }
}
