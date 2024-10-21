import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:courtly/presentation/widgets/reviews/rating_bar.dart';
import 'package:courtly/presentation/widgets/reviews/review_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [ReviewsPage] is a page to show user's reviews.
class ReviewsPage extends StatelessWidget {
  ReviewsPage({super.key});

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  /// [_userReviewsNotifier] is the list of user reviews.
  final ValueNotifier<List<dynamic>> _userReviewsNotifier =
      ValueNotifier([1, 2, 3, 1, 2, 3, 1, 2, 3]);

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [chipLabelItems] is the items of filter chip.
    final List<Widget> chipLabelItems = <Widget>[const Text("All")] +
        List.generate(
            4,
            (e) => Row(
                  children: [
                    Text((e + 1).toString()),
                    const SizedBox(width: 5),
                    HeroIcon(HeroIcons.star,
                        style: HeroIconStyle.solid,
                        size: 16,
                        color: colorExt.star)
                  ],
                ));

    return Scaffold(
      backgroundColor: colorExt.backgroundSecondary,
      appBar: const BackableCenteredAppBar(title: "Reviews"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: PAGE_PADDING_MOBILE,
                right: PAGE_PADDING_MOBILE,
              ),
              color: colorExt.background,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          HeroIcon(HeroIcons.star,
                              style: HeroIconStyle.solid,
                              size: 36,
                              color: colorExt.star),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "4.9",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                TextSpan(
                                    text: " / 5.0",
                                    style: TextStyle(
                                        color: colorExt.highlight,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12))
                              ]))
                        ],
                      ),
                      RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                              text: "Based on\n",
                              style: TextStyle(
                                  color: colorExt.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              children: [
                                TextSpan(
                                    text: "14 reviews",
                                    style: TextStyle(
                                        color: colorExt.highlight,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12))
                              ]))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      RatingBar(rating: 1, value: 0),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(rating: 2, value: 0.2),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(rating: 3, value: 0.4),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(rating: 4, value: 0.75),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBar(rating: 5, value: 0.8)
                    ],
                  )
                ],
              ),
            ),
            StickyHeader(
                header: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: colorExt.background,
                      border: Border(
                          top: BorderSide(width: 1, color: colorExt.outline!),
                          bottom:
                              BorderSide(width: 1, color: colorExt.outline!))),
                  child: Container(
                    margin: const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                    child: FilterChips(
                        items: chipLabelItems,
                        selectedItem: _selectedChipNotifier),
                  ),
                ),
                content: SizedBox(
                  child: ValueListenableBuilder(
                      valueListenable: _userReviewsNotifier,
                      builder:
                          (BuildContext context, List<dynamic> userReview, _) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ReviewCard(
                                  userProfile: "",
                                  userName: "EL Gasing",
                                  reviewDate: DateTime.now(),
                                  rate: 3,
                                  review: "This is a review from user.");
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 10),
                            itemCount: userReview.length);
                      }),
                ))
          ],
        ),
      )),
    );
  }
}
