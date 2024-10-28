import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  /// [_formKeys] is the map of form keys.
  /// This keys is used to store the register form keys.
  final Map<String, GlobalKey<FormState>> _formKeys = {
    "oldPassword": GlobalKey<FormState>(),
    "newPassword": GlobalKey<FormState>(),
  };

  /// [_textInputControllers] is the register form controllers.
  /// This controllers is used to store the register form controllers.
  final Map<String, TextEditingController> _textInputControllers = {
    "oldPassword": TextEditingController(),
    "newPassword": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };

  /// [_currentStep] is the current register step.
  /// This is set to 0 by default.
  int _currentStep = 0;

  /// [_nextStep] is a function to go to the next step.
  ///
  /// - Returns: void
  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the color extension of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [changePasswordSteps] is the list of steps for changing password.
    /// This list is used to store the steps of changing password.
    final List<Widget> changePasswordSteps = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Change Password",
            style: TextStyle(
                fontSize: 28,
                color: colorExt.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Please enter your current password to set a new one",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: _formKeys["oldPassword"],
            child: Column(
              children: [
                TextFormField(
                    controller: _textInputControllers["oldPassword"],
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        // Move to next step
                        _nextStep();
                      },
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all(const Size.fromHeight(0)),
                      ),
                      child: const Text("Check & Proceed"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SecondaryButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          minimumSize:
                              WidgetStateProperty.all(const Size.fromHeight(0)),
                        ),
                        child: const Text("Cancel")),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Change Password",
            style: TextStyle(
                fontSize: 28,
                color: colorExt.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Create a strong & unique password to keep your information safe!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: _formKeys["newPassword"],
            child: Column(
              children: [
                Column(
                  children: [
                    TextFormField(
                        controller: _textInputControllers["newPassword"],
                        style: const TextStyle(fontSize: 14),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          label: Text("New Password"),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _textInputControllers["confirmPassword"],
                        style: const TextStyle(fontSize: 14),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          label: Text("Confirm Password"),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    PrimaryButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all(const Size.fromHeight(0)),
                      ),
                      child: const Text("Change"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SecondaryButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          minimumSize:
                              WidgetStateProperty.all(const Size.fromHeight(0)),
                        ),
                        child: const Text("Cancel")),
                  ],
                )
              ],
            ),
          ),
        ],
      )
    ];

    return Scaffold(
        backgroundColor: colorExt.background,
        body: SafeArea(
            minimum:
                const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
            child: changePasswordSteps[_currentStep]));
  }
}
