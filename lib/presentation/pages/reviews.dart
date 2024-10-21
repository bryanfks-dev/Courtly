import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: const BackableCenteredAppBar(title: "Reviews"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              color: colorExt.background,
              child: Column(
                children: [Row(
                  children: [
                    
                  ],
                )],
              ),
            )
          ],
        ),
      )),
    );
  }
}
