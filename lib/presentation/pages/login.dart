import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/data/dto/login_form_dto.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [LoginPage] is page for /login route.
/// This page is used to login into existing account.
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  /// [_formKey] is the key for the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// [_data] is the login form data.
  /// This data is used to store the login form contents.
  final LoginFormDTO _data = LoginFormDTO(
    username: "",
    password: "",
  );

  /// [_textInputControllers] is the map of text input keys.
  final Map<String, TextEditingController> _textInputControllers = {
    "username": TextEditingController(),
    "password": TextEditingController(),
  };

  /// [_obsecureTextNotifier] is the notifier for obsecure text.
  /// This notifier is used to toggle the password visibility.
  final ValueNotifier<bool> _obsecureTextNotifier = ValueNotifier(true);

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
              "Login",
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
              "Signing into your existing account",
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
                        controller: _textInputControllers["username"],
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text("Username"),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                        valueListenable: _obsecureTextNotifier,
                        builder: (BuildContext context, bool obsecureText, _) {
                          return TextFormField(
                            controller: _textInputControllers["password"],
                            style: const TextStyle(fontSize: 14),
                            obscureText: obsecureText,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              label: const Text("Password"),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              suffixIcon: IconButton(
                                icon: HeroIcon((obsecureText)
                                    ? HeroIcons.eyeSlash
                                    : HeroIcons.eye),
                                iconSize: 16,
                                onPressed: () {
                                  _obsecureTextNotifier.value = !obsecureText;
                                },
                              ),
                            ),
                          );
                        }),
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
                  child: const Text("Login"),
                ),
                const SizedBox(height: 10),
                SecondaryButton(
                  onPressed: () {
                    // Navigate to register page
                    Navigator.pushNamed(context, Routes.register);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("I'm new here"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
