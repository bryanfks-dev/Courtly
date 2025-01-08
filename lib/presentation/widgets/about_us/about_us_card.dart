import 'package:courtly/core/config/app_color_extension.dart';
import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {
  const AboutUsCard(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.position});

  /// [imagePath] is the path of the image to be shown in the card.
  final String imagePath;

  /// [name] is the name of the person to be shown in the card.
  final String name;

  /// [position] is the position of the person to be shown in the card.
  final String position;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return SizedBox(
      width: double.maxFinite,
      height: 130,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
                color: colorExt.outline,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: colorExt.outline!),
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 5,
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: colorExt.background!.withOpacity(0.95),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorExt.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    position,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorExt.highlight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
