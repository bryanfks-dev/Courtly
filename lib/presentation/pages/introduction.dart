import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:introduction_screen/introduction_screen.dart';

/// [IntroductionPage] is the introduction page widget.
class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPage();
}

class _IntroductionPage extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of [AppColorsExtension] from the current theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [customPageViewModel] is a function to create a custom page view model.
    /// It takes [title] and [body] as the title and body of the page.
    ///
    /// - Parameters:
    ///  - [title]: The title of the page.
    ///  - [body]: The body of the page.
    ///
    /// - Returns: PageViewModel
    PageViewModel customPageViewModel({
      required String imageUrl,
      required String title,
      required String body,
    }) =>
        (PageViewModel(
            image: SvgPicture(
              AssetBytesLoader(imageUrl),
            ),
            titleWidget: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: colorExt.textPrimary)),
            bodyWidget: Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: colorExt.textPrimary),
            ),
            decoration: const PageDecoration(
              imageFlex: 2,
              contentMargin: EdgeInsets.all(0),
              titlePadding: EdgeInsets.only(bottom: 24),
              imagePadding: EdgeInsets.all(0),
              bodyAlignment: Alignment.center,
            )));

    return Scaffold(
      backgroundColor: colorExt.background,
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: IntroductionScreen(
            globalBackgroundColor: colorExt.background,
            dotsDecorator: DotsDecorator(
              color: colorExt.outline!,
              spacing: const EdgeInsets.all(3),
              activeColor: colorExt.primary,
              size: const Size(10, 10),
              activeSize: const Size(17, 10),
              activeShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ),
            controlsPadding: const EdgeInsets.only(
                left: 0, right: 0, bottom: PAGE_PADDING_MOBILE),
            showBackButton: true,
            isProgressTap: false,
            done: Text("Done",
                style: TextStyle(
                    fontSize: 14,
                    color: colorExt.primary,
                    fontWeight: FontWeight.w500)),
            onDone: () {},
            next: HeroIcon(
              HeroIcons.chevronRight,
              color: colorExt.textPrimary,
              size: 20,
            ),
            back: HeroIcon(
              HeroIcons.chevronLeft,
              color: colorExt.textPrimary,
              size: 20,
            ),
            pages: [
              customPageViewModel(
                  imageUrl: "assets/images/welcome.svg.vec",
                  title: "Welcome 👋 !",
                  body:
                      "Meet Courtly! Booking a court never have been this easier!"),
              customPageViewModel(
                  imageUrl: "assets/images/perfect_court.svg.vec",
                  title: "Find Your Perfect Court!",
                  body:
                      "Matching your time and availability to find the perfect court and match for your game"),
              customPageViewModel(
                  imageUrl: "assets/images/easy_payment.svg.vec",
                  title: "Easy Booking & Payments",
                  body:
                      "Secure your court in just a few taps with flexible payment options"),
              customPageViewModel(
                  imageUrl: "assets/images/ready_to_play.svg.vec",
                  title: "Ready to Play?",
                  body:
                      "Courtly is here to make your game easier and more enjoyable, let's start booking today!")
            ],
          )),
    );
  }
}
