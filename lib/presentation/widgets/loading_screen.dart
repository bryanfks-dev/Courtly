import 'package:flutter/material.dart';

/// [LoadingScreen] is a widget that displays a loading screen.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.label});

  /// [label] is the label for the loading screen.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text(label ?? 'Loading...'),
        ],
      ),
    );
  }
}
