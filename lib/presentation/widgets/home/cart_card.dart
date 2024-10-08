import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:flutter/material.dart';

/// [CartCard] is a card that displays the selected item in the cart.
class CartCard extends StatelessWidget {
  const CartCard(
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorExt.outline!, width: 1),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: colorExt.star,
                      ),
                      const SizedBox(width: 3),
                      Text("$rating",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Text(
                    "${sportType.label} Court",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    vendorName,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: colorExt.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "$openTime - $closeTime",
                    style: TextStyle(fontSize: 12, color: colorExt.highlight),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: colorExt.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    address,
                    style: TextStyle(fontSize: 12, color: colorExt.highlight),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
