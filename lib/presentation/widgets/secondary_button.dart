import 'package:flutter/material.dart';

/// SecondaryButton is a secondary button used in the app.
/// It is a custom button with white background color and red border.
///
/// [onPressed] parameter specifies the function to be called when button is pressed.
/// [child] parameter specifies the child of the button.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  /// onPressed is the function to be called when button is pressed.
  final VoidCallback onPressed;

  /// child is the widget to be displayed inside the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.red),
          minimumSize: const Size.fromHeight(0),
          padding: const EdgeInsets.symmetric(vertical: 10),
          foregroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white),
      onPressed: onPressed,
      child: child,
    );
  }
}
