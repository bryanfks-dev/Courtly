import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

/// [NotLoggedInProfile] is profile page content when user is not logged in.
class NotLoggedInProfile extends StatelessWidget {
  const NotLoggedInProfile({super.key});

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the color extension.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return SafeArea(
      child: Container(
        color: colorExt.background,
        padding: const EdgeInsets.all(PAGE_PADDING_MOBILE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture(const AssetBytesLoader("assets/images/wait_up.svg.vec"),
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Wait Upp!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Column(
              children: [
                Text(
                  "Hold on! You are not logged in yet.",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Login here.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                onPressed: () {
                  // Navigate to login page.
                  Navigator.pushNamed(context, Routes.login);
                },
                style: ButtonStyle(
                  minimumSize:
                      WidgetStateProperty.all(const Size.fromHeight(0)),
                ),
                child: const Text("Let's Login!",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)))
          ],
        ),
      ),
    );
  }
}
