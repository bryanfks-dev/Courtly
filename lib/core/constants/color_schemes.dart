import 'package:flutter/material.dart';

/// [ColorSchemes] class contains all the color schemes used in the app.
/// It is used to maintain the color schemes in one place.
///
/// There are two types of color schemes available in the app,
/// which are Light and Dark schemes.
///
/// Each color scheme must contains the following colors:
/// - [Primary] the primary color of the app
/// - [Default] the default color of the text
/// - [Subtle] the softer and more neutral color to use
/// - [Highlight] the bright and attention grabbing color
/// - [Success] the color to indicate success
/// - [Warning] the color to indicate warning
/// - [Danger] the color to indicate danger
/// - [Star] the color to indicate star
/// - [PrimaryBackground] the primary background color
/// - [SecondaryBackground] the secondary background color
///
/// [ColorSchemes] class is also used to assign the color schemes to the
/// [ThemeData] in the [AppThemes] class.
class ColorSchemes {
  // Light color schemes
  static Color primaryLight = const Color(0xFF00BFB2);

  static Color defaultLight = const Color(0xFF000000);
  static Color subtleLight = const Color(0xFFD9D9D9);
  static Color highlightLight = const Color(0xFF757575);

  static Color successLight = const Color(0xFF4CAF50);
  static Color warningLight = const Color(0xFFFFCC00);
  static Color errorLight = const Color(0xFFF44336);

  static Color starLight = const Color(0xFFFFD93D);

  static Color primaryBackgroundLight = const Color(0xFFFFFFFF);
  static Color secondaryBackgroundLight = const Color(0xFFF5F5F5);

  // Dark color schemes
}
