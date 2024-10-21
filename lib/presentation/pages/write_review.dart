import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [WriteReviewPage] is a widget that is used to display the write review
/// page of the application.
class WriteReviewPage extends StatelessWidget {
  WriteReviewPage({super.key});

  /// [_selectedStartNotifier] is a value notifier that is used to notify
  final ValueNotifier<int> _selectedStartNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [starButton] is a function that returns a star button.
    /// This button is used to rate the place.
    ///
    /// - Returns: [IconButton]
    GestureDetector starButton(int currentIndex) {
      /// [starCount] is the current count of the passed star button.
      int starCount = currentIndex + 1;

      return GestureDetector(
        onTap: () {
          _selectedStartNotifier.value = starCount;
        },
        child: HeroIcon(HeroIcons.star,
            style: HeroIconStyle.solid,
            size: 36,
            color: (starCount <= _selectedStartNotifier.value)
                ? colorExt.warning
                : colorExt.outline),
      );
    }

    return Scaffold(
        backgroundColor: colorExt.background,
        appBar: const BackableCenteredAppBar(title: "Write a Review"),
        body: SafeArea(
            minimum:
                const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Lunggu Sport Centre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Basketball Court",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "How do you rate the place?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your review helps others make informed decisions and helps vendor maintain high-quality service.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorExt.highlight, fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: _selectedStartNotifier,
                    builder: (BuildContext _, int __, Widget? ___) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(5, (index) => starButton(index)),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  maxLines: 10,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Write your thoughts here...",
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size.fromHeight(0)),
                    ),
                    child: const Text("Submit Review")),
                const SizedBox(
                  height: 20,
                )
              ],
            ))));
  }
}
