import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/domain/entities/order.dart';
import 'package:courtly/presentation/blocs/states/write_review_state.dart';
import 'package:courtly/presentation/blocs/write_review_bloc.dart';
import 'package:courtly/presentation/validators/write_review_validator.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/write_review/star_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [WriteReviewPage] is a widget that is used to display the write review
/// page of the application.
class WriteReviewPage extends StatelessWidget {
  WriteReviewPage({super.key, required this.order});

  /// [order] is the order entity.
  final Order order;

  /// [_validator] is a write review validator.
  final WriteReviewValidator _validator = WriteReviewValidator();

  /// [_controller] is a text editing controller.
  final TextEditingController _controller = TextEditingController();

  /// [_selectedStarNotifier] is a value notifier that is used to notify
  final ValueNotifier<int> _selectedStarNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
        backgroundColor: colorExt.background,
        appBar: const BackableCenteredAppBar(title: "Write a Review"),
        body: BlocConsumer<WriteReviewBloc, WriteReviewState>(
            listener: (BuildContext context, WriteReviewState state) {
          // Check for states
          if (state is WriteReviewErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }

          if (state is WriteReviewSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Review submitted")));

            // Pop until the first screen
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        }, builder: (BuildContext context, WriteReviewState state) {
          // Check for states
          if (state is! WriteReviewInitialState &&
              state is! WriteReviewErrorState) {
            return const LoadingScreen();
          }

          return SafeArea(
              minimum:
                  const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order.vendor.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorExt.textPrimary,
                    ),
                  ),
                  Text(
                    order.vendor.address,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorExt.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${order.courtType} Court",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorExt.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "How do you rate the place?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorExt.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your review helps others make informed decisions and helps vendor maintain high-quality service.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorExt.highlight,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _selectedStarNotifier,
                      builder: (BuildContext _, int __, Widget? ___) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              5,
                              (index) => StarButton(
                                  currentIndex: index,
                                  selectedStarCountNotifier:
                                      _selectedStarNotifier)),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _controller,
                    maxLines: 10,
                    style: TextStyle(fontSize: 14),
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: "Write your thoughts here (max 100 words)",
                      counterText: "",
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                      onPressed: () {
                        // Validate the rating
                        final String? msg = _validator
                            .validateRating(_selectedStarNotifier.value);

                        // Validate the rating
                        if (msg != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(msg)));

                          return;
                        }

                        // Submit review
                        context.read<WriteReviewBloc>().submitReview(
                            vendorId: order.vendor.id,
                            courtType: order.courtType,
                            rating: _selectedStarNotifier.value,
                            review: _controller.text);
                      },
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size.fromHeight(0)),
                      ),
                      child: const Text("Submit Review")),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )));
        }));
  }
}
