import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/domain/entities/review.dart';
import 'package:courtly/presentation/widgets/reviews/star_row.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

/// [ReviewCard] is a card to show the review of the user.
/// This card will show the user's name, profile, date of the review, rate,
/// and the review itself.
class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [dateFormatter] is the date formatter to format the date of the review.
    final DateFormat dateFormatter = DateFormat("MMM d, yyyy");

    return Container(
      padding: const EdgeInsets.all(PAGE_PADDING_MOBILE),
      color: colorExt.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: colorExt.outline,
                          shape: BoxShape.circle,
                          image: review.user.profilePictureUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      review.user.profilePictureUrl),
                                  fit: BoxFit.cover)
                              : null),
                      child: review.user.profilePictureUrl.isEmpty
                          ? HeroIcon(
                              HeroIcons.userCircle,
                              color: colorExt.highlight,
                              style: HeroIconStyle.solid,
                              size: 64,
                            )
                          : null),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    review.user.username,
                    style: TextStyle(
                        color: colorExt.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Text(
                dateFormatter.format(review.date),
                style: TextStyle(
                  color: colorExt.highlight,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          StarRow(rate: review.rating),
          const SizedBox(height: 5),
          Text(
            review.review,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: colorExt.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
