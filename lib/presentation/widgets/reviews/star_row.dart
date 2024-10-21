import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [StarRow] is a row of stars to show the rating of the review.
/// This row will show the stars based on the rating of the review.
class StarRow extends StatelessWidget {
  const StarRow({super.key, required this.rate});

  /// [rate] is the rate of the review.
  final int rate;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Row(
      children: List.generate(
          5,
          (index) => HeroIcon(HeroIcons.star,
              style: HeroIconStyle.solid,
              size: 16,
              color: (index < rate) ? colorExt.star : colorExt.outline)),
    );
  }
}
