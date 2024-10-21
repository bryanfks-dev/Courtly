import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [RatingBar] is a widget that displays the rating of a product.
/// It displays the rating in the form of stars and a progress bar.
class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
    required this.rating,
    required this.value,
  });

  /// [rating] is the number of stars to be displayed.
  final int rating;

  /// [value] is the value of the rating.
  ///
  /// Guide to the value of the rating:
  /// To find the value of the rating, simply divide the current rating count
  /// with the total rating count.
  /// For example, if the current rating count is 4 and the total rating count
  /// is 5, with 4/5 = 0.8, hence the value of the rating is 0.8.
  final double value;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Row(
      children: [
        Row(
          children: [
            Text(rating.toString(),
                style: TextStyle(
                    color: colorExt.textPrimary,
                    fontSize: 14,
                    fontFamily: "Roboto")),
            const SizedBox(
              width: 5,
            ),
            HeroIcon(HeroIcons.star,
                style: HeroIconStyle.solid, size: 18, color: colorExt.star),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ],
    );
  }
}
