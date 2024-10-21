import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [StarButton] is a widget that is used to display a star button.
/// This button is used to rate the place.
class StarButton extends StatelessWidget {
  const StarButton(
      {super.key,
      required this.currentIndex,
      required this.selectedStarCountNotifier});

  /// [currentIndex] is the index of the current star button.
  final int currentIndex;

  /// [selectedStarCount] is the count of the selected star button.
  final ValueNotifier<int> selectedStarCountNotifier;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [starCount] is the current count of the passed star button.
    int starCount = currentIndex + 1;

    return GestureDetector(
      onTap: () {
        // Set the selected star count
        selectedStarCountNotifier.value = starCount;
      },
      child: HeroIcon(HeroIcons.star,
          style: HeroIconStyle.solid,
          size: 36,
          color: (starCount <= selectedStarCountNotifier.value)
              ? colorExt.star
              : colorExt.outline),
    );
  }
}
