import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [AppThemes] is a class that contains all the theme data for the application.
class AppThemes {
  // Light theme
  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: ColorSchemes.primaryLight,
      textTheme: ThemeData.light().textTheme.apply(fontFamily: "Inter"),
      primaryTextTheme:
          ThemeData.light().primaryTextTheme.apply(fontFamily: "Inter"),
      chipTheme: ChipThemeData(
        labelStyle: TextStyle(
            color: ColorSchemes.highlightLight,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: "Inter"),
        secondaryLabelStyle: TextStyle(
            color: ColorSchemes.primaryBackgroundLight,
            fontWeight: FontWeight.w500),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return BorderSide(color: ColorSchemes.subtleLight);
          }

          return BorderSide(color: ColorSchemes.primaryLight);
        }),
        color: WidgetStateColor.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return ColorSchemes.primaryBackgroundLight;
          }

          return ColorSchemes.primaryLight;
        }),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor: ColorSchemes.subtleLight,
          color: ColorSchemes.primaryLight),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: ColorSchemes.primaryBackgroundLight),
      inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: ColorSchemes.highlightLight,
          suffixIconColor: ColorSchemes.highlightLight,
          floatingLabelStyle:
              TextStyle(color: ColorSchemes.primaryLight, fontFamily: "Inter"),
          labelStyle: TextStyle(
              color: ColorSchemes.highlightLight,
              fontSize: 14,
              fontFamily: "Inter"),
          hintStyle: TextStyle(
              color: ColorSchemes.highlightLight,
              fontSize: 14,
              fontFamily: "Inter"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.subtleLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.primaryLight),
          ),
          errorStyle: TextStyle(color: ColorSchemes.errorLight),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.errorLight),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorSchemes.errorLight),
          )),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(ColorSchemes.highlightLight),
        textStyle: const WidgetStatePropertyAll(TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Inter")),
      )),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            textStyle: WidgetStatePropertyAll(TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter"))),
      ),
      dividerTheme: DividerThemeData(color: ColorSchemes.subtleLight),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorSchemes.primaryBackgroundLight,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorSchemes.primaryBackgroundLight,
          selectedIconTheme: IconThemeData(
            color: ColorSchemes.primaryLight,
          ),
          unselectedIconTheme: IconThemeData(
            color: ColorSchemes.highlightLight,
          )),
      extensions: <ThemeExtension<dynamic>>[
        AppColorsExtension(
          primary: ColorSchemes.primaryLight,
          background: ColorSchemes.primaryBackgroundLight,
          backgroundSecondary: ColorSchemes.secondaryBackgroundLight,
          textPrimary: ColorSchemes.defaultLight,
          highlight: ColorSchemes.highlightLight,
          outline: ColorSchemes.subtleLight,
          success: ColorSchemes.successLight,
          warning: ColorSchemes.warningLight,
          danger: ColorSchemes.errorLight,
          star: ColorSchemes.starLight,
        ),
      ]);

  // Dark theme
  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: ColorSchemes.primaryLight,
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: "Inter"),
    primaryTextTheme:
        ThemeData.dark().primaryTextTheme.apply(fontFamily: "Inter"),
  );
}
