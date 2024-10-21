import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [CourtCard] is a card that displays the selected item in the cart.
class CourtCard extends StatelessWidget {
  const CourtCard(
      {super.key,
      required this.imgUrl,
      required this.rating,
      required this.sportType,
      required this.vendorName,
      required this.openTime,
      required this.closeTime,
      required this.address});

  /// [imgUrl] is the image URL of the court.
  final String imgUrl;

  /// [rating] is the rating of the cout.
  final double rating;

  /// [sportType] is the type of court sport.
  final Sports sportType;

  /// [vendorName] is the name of the court vendor.
  final String vendorName;

  /// [openTime] is the opening time of vendor / court.
  final String openTime;

  /// [closeTime] is the closing time of vendor / court.
  final String closeTime;

  /// [address] is the address of the vendor.
  final String address;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return InkWell(
      onTap: () {},
      child: Container(
        width: double.maxFinite,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorExt.outline!, width: 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: colorExt.outline,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        HeroIcon(
                          HeroIcons.star,
                          size: 16,
                          color: colorExt.star,
                          style: HeroIconStyle.solid,
                        ),
                        const SizedBox(width: 3),
                        Text(rating.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${sportType.label} Court",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          PAGE_PADDING_MOBILE * 11,
                      child: Text(
                        vendorName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        HeroIcon(
                          HeroIcons.clock,
                          size: 16,
                          color: colorExt.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$openTime - $closeTime",
                          style: TextStyle(
                              fontSize: 12, color: colorExt.highlight),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeroIcon(
                          HeroIcons.mapPin,
                          size: 16,
                          color: colorExt.primary,
                          style: HeroIconStyle.values[1],
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              PAGE_PADDING_MOBILE * 11,
                          child: Text(
                            address,
                            style: TextStyle(
                                fontSize: 12, color: colorExt.highlight),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
