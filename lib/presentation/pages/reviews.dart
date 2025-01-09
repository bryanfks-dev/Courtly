import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/utils/get_digits.dart';
import 'package:courtly/presentation/blocs/reviews_bloc.dart';
import 'package:courtly/presentation/blocs/states/reviews_state.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/reviews/rating_bar.dart';
import 'package:courtly/presentation/widgets/reviews/review_card.dart';
import 'package:courtly/presentation/widgets/try_again_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [ReviewsPage] is a page to show user's reviews.
class ReviewsPage extends StatefulWidget {
  const ReviewsPage(
      {super.key, required this.courtType, required this.vendorId});

  /// [courtType] is the type of the court.
  final String courtType;

  /// [vendorId] is the id of the vendor.
  final int vendorId;

  @override
  State<ReviewsPage> createState() => _ReviewsPage();
}

class _ReviewsPage extends State<ReviewsPage> {
  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  /// [_calcStarValue] is a method to calculate the value of the star.
  ///
  /// Parameters:
  ///   - [starCount] is the count of the star.
  ///   - [totalReviews] is the total rating.
  ///
  /// Returns a [double] of the star value.
  double _calcStarValue({required int starCount, required int totalReviews}) {
    // Return 0 if the total reviews is 0.
    if (totalReviews == 0) {
      return 0;
    }

    return starCount / totalReviews;
  }

  /// [_formatTotalReviews] is a method to format the total reviews.
  ///
  /// Parameters:
  ///   - [totalReviews] is the total reviews.
  ///
  /// Returns a [String] of the formatted total reviews.
  String _formatTotalReviews(int totalReviews) {
    // Get the digits of the total reviews.
    final int digits = getDigits(number: totalReviews);

    // Return the formatted total reviews.
    if (digits <= 2) {
      return totalReviews.toString();
    }

    if (digits == 3) {
      return "${totalReviews ~/ 100}00+";
    }

    if (digits <= 5) {
      return "${totalReviews ~/ 1000}k+";
    }

    return "${totalReviews ~/ 1000000}M+";
  }

  @override
  void initState() {
    super.initState();

    // Get reviews from the server.
    BlocProvider.of<ReviewsBloc>(context)
        .getReviews(vendorId: widget.vendorId, courtType: widget.courtType);
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [chipLabelItems] is the items of filter chip.
    final List<Widget> chipLabelItems = <Widget>[const Text("All")] +
        List.generate(
            5,
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
      body: BlocConsumer<ReviewsBloc, ReviewsState>(
          listener: (BuildContext context, ReviewsState state) {
        // Show error message if there is an error.
        if (state is ReviewsErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      }, builder: (BuildContext context, ReviewsState state) {
        // Check for states.
        if (state is ReviewsErrorState) {
          return TryAgainScreen(
              onTryAgain: () => BlocProvider.of<ReviewsBloc>(context)
                  .getReviews(
                      vendorId: widget.vendorId, courtType: widget.courtType));
        }

        if (state is! ReviewsLoadedState) {
          return const Center(child: LoadingScreen());
        }

        return SafeArea(
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
                            Text.rich(
                                style: TextStyle(
                                    color: colorExt.textPrimary,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                                TextSpan(
                                    text: state.totalRating.toString(),
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
                        Text.rich(
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: colorExt.textPrimary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            TextSpan(text: "Based on\n", children: [
                              TextSpan(
                                  text:
                                      "${_formatTotalReviews(state.totalReviews)} reviews",
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
                        RatingBar(
                            rating: 1,
                            value: _calcStarValue(
                                starCount: state.reviewStars.oneStar,
                                totalReviews: state.totalReviews)),
                        const SizedBox(
                          height: 5,
                        ),
                        RatingBar(
                            rating: 2,
                            value: _calcStarValue(
                                starCount: state.reviewStars.twoStar,
                                totalReviews: state.totalReviews)),
                        const SizedBox(
                          height: 5,
                        ),
                        RatingBar(
                            rating: 3,
                            value: _calcStarValue(
                                starCount: state.reviewStars.threeStar,
                                totalReviews: state.totalReviews)),
                        const SizedBox(
                          height: 5,
                        ),
                        RatingBar(
                            rating: 4,
                            value: _calcStarValue(
                                starCount: state.reviewStars.fourStar,
                                totalReviews: state.totalReviews)),
                        const SizedBox(
                          height: 5,
                        ),
                        RatingBar(
                            rating: 5,
                            value: _calcStarValue(
                                starCount: state.reviewStars.fiveStar,
                                totalReviews: state.totalReviews))
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
                            bottom: BorderSide(
                                width: 1, color: colorExt.outline!))),
                    child: Container(
                      margin: const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                      child: FilterChips(
                        items: chipLabelItems,
                        selectedItem: _selectedChipNotifier,
                        onSelected: () {
                          // Get reviews from the server.
                          context.read<ReviewsBloc>().getReviews(
                              vendorId: widget.vendorId,
                              courtType: widget.courtType,
                              rating: _selectedChipNotifier.value);
                        },
                      ),
                    ),
                  ),
                  content: BlocBuilder<ReviewsBloc, ReviewsState>(
                      builder: (BuildContext context, ReviewsState state) {
                    // Show loading screen if the state is not loaded.
                    if (state is! ReviewsLoadedState) {
                      return const LoadingScreen();
                    }

                    // Show no reviews found if the reviews is empty.
                    if (state.reviews.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text(
                            "No reviews found",
                            style: TextStyle(color: colorExt.highlight),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ReviewCard(review: state.reviews[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10),
                          itemCount: state.reviews.length),
                    );
                  }))
            ],
          ),
        ));
      }),
    );
  }
}
