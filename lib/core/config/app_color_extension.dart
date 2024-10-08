import 'package:flutter/material.dart';

/// [AppColorsExtension] is a class that contains all the color data
/// for the application.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.primary,
    required this.background,
    required this.backgroundSecondary,
    required this.textPrimary,
    required this.highlight,
    required this.outline,
    required this.success,
    required this.warning,
    required this.danger,
    required this.star,
  });

  /// [primary] is the primary color of the application.
  final Color? primary;

  /// [background] is the background color of the application.
  final Color? background;

  /// [backgroundSecondary] is the secondary background color of the application.
  final Color? backgroundSecondary;

  /// [textPrimary] is the primary text color of the application.
  final Color? textPrimary;

  /// [highlight] is the highlight color of the application.
  final Color? highlight;

  /// [outline] is the outline color of the application.
  final Color? outline;

  /// [success] is the success color of the application.
  final Color? success;

  /// [warning] is the warning color of the application.
  final Color? warning;

  /// [danger] is the danger color of the application.
  final Color? danger;

  /// [star] is the active star color of the application.
  final Color? star;

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? background,
    Color? backgroundSecondary,
    Color? textPrimary,
    Color? highlight,
    Color? outline,
    Color? success,
    Color? warning,
    Color? danger,
    Color? star,
  }) {
    return AppColorsExtension(
        primary: primary ?? this.primary,
        background: background ?? this.background,
        backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
        textPrimary: textPrimary ?? this.textPrimary,
        highlight: highlight ?? this.highlight,
        outline: outline ?? this.outline,
        success: success ?? this.success,
        warning: warning ?? this.warning,
        danger: danger ?? this.danger,
        star: star ?? this.star);
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
        primary: Color.lerp(primary, other.primary, t),
        background: Color.lerp(background, other.background, t),
        backgroundSecondary:
            Color.lerp(backgroundSecondary, backgroundSecondary, t),
        textPrimary: Color.lerp(textPrimary, other.textPrimary, t),
        highlight: Color.lerp(highlight, other.highlight, t),
        outline: Color.lerp(outline, other.outline, t),
        success: Color.lerp(success, other.success, t),
        warning: Color.lerp(warning, other.warning, t),
        danger: Color.lerp(danger, other.danger, t),
        star: Color.lerp(star, other.star, t));
  }
}
