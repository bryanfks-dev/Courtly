import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

/// ChangeUsernamePage is page for /change-username route.
/// This page is used to change the username of the account.
class ChangeUsernamePage extends StatelessWidget {
  ChangeUsernamePage({super.key});

  /// [_formKey] is the key for the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// [_usernameController] is a controller of username text input.
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return Scaffold(
      backgroundColor: colorExt.background,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Change Username",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorExt.primary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Update your username to refresh your profile identity",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text("Username"),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        )),
                  
                  ],
                )),
            const SizedBox(height: 40),
            Column(
              children: [
                PrimaryButton(
                  onPressed: () {
                    // Return to previous page
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Change"),
                ),
                const SizedBox(height: 10),
                SecondaryButton(
                  onPressed: () {
                    // Navigate to register page
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
