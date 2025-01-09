import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

/// [TryAgainScreen] is a widget that will be shown when the user encounters
/// an error and wants to try again by pressing the try again button.
class TryAgainScreen extends StatelessWidget {
  const TryAgainScreen({super.key, required this.onTryAgain});

  /// [onTryAgain] is a function that will be called when the user presses
  /// the try again button
  final Function onTryAgain;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an extension of the [AppColorsExtension] class.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.png"),
              SizedBox(height: 10),
              Text("Failed to load data",
                  style: TextStyle(
                      color: colorExt.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              PrimaryButton(
                onPressed: () => onTryAgain(),
                style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16))),
                child: Text("Try again",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          )),
    );
  }
}
