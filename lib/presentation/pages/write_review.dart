import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

/// [WriteReviewPage] is a widget that is used to display the write review
/// page of the application.
class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension colorExt = Theme.of(context).extension()!;
    return Scaffold(
        backgroundColor: colorExt.background,
        appBar: const BackableCenteredAppBar(title: 'Write a Review'),
        body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Lunggu Sport Centre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lunggu Sport Centre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "How do you rate the place?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your review helps others make informed decisions and helps vendor maintain high-quality service.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: colorExt.highlight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "INI ADALAH BINTANG",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  maxLines: 10,
                  decoration:
                      InputDecoration(hintText: "Write your thoughts here..."),
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size.fromHeight(0)),
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 14))),
                    child: Text(
                      "Submit Review",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ))
              ],
            ))));
  }
}
