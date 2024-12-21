import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';

/// [LoadingScreen] is a widget that displays a loading screen.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.label});

  /// [label] is the label for the loading screen.
  final String? label;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(label ?? 'Loading...',
              style: TextStyle(fontSize: 14, color: colorExt.textPrimary)),
        ],
      ),
    );
  }
}
