import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/domain/entities/register_form_data.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';

/// [RegisterPage] is page for /register route.
/// This page is used to register a new account.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  /// [_currentStep] is the current register step.
  int _currentStep = 0;

  /// [_data] is the register form data.
  /// This data is used to store the register form contents.
  final RegisterFormData _data = RegisterFormData(
    username: "",
    password: "",
    confirmPassword: "",
    phoneNumber: "",
  );

  /// [_formKeys] is the map of form keys.
  /// This keys is used to store the register form keys.
  final Map<String, GlobalKey<FormState>> _formKeys = {
    "username": GlobalKey<FormState>(),
    "phoneNumber": GlobalKey<FormState>(),
    "password": GlobalKey<FormState>(),
  };

  /// [_textInputControllers] is the register form controllers.
  /// This controllers is used to store the register form controllers.
  final Map<String, TextEditingController> _textInputControllers = {
    "username": TextEditingController(),
    "phoneNumber": TextEditingController(),
    "password": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };

  /// [_nextStep] is a function to go to the next step.
  ///
  /// - Returns: void
  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  /// [_previousStep] is a function to go to the previous step.
  ///
  /// - Returns: void
  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the color extension of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    /// [registerSteps] is the list of register steps.
    /// This list is used to store the register form contents.
    final List<Widget> registerSteps = [
      Form(
        key: _formKeys["username"],
        child: Column(
          children: [
            TextFormField(
                controller: _textInputControllers["username"],
                decoration: const InputDecoration(
                  label: Text("Username"),
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
                        MaterialStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Next",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SecondaryButton(
                    onPressed: () {
                      // Navigate to login page
                      Navigator.pushNamed(context, Routes.login);
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(0)),
                    ),
                    child: const Text("I already have an account",
                        style: TextStyle(fontSize: 16))),
              ],
            )
          ],
        ),
      ),
      Form(
        key: _formKeys["phoneNumber"],
        child: Column(
          children: [
            TextFormField(
                controller: _textInputControllers["phoneNumber"],
                decoration: const InputDecoration(
                  label: Text("Phone Number"),
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
                        MaterialStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Next",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SecondaryButton(
                    onPressed: () {
                      // Move to previous step
                      _previousStep();
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(0)),
                    ),
                    child: const Text("Back", style: TextStyle(fontSize: 16))),
              ],
            )
          ],
        ),
      ),
      Form(
        key: _formKeys["password"],
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                    controller: _textInputControllers["password"],
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _textInputControllers["confirmPassword"],
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
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
                        MaterialStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Create Account",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SecondaryButton(
                    onPressed: () {
                      // Move to previous step
                      _previousStep();
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(0)),
                    ),
                    child: const Text("Back", style: TextStyle(fontSize: 16))),
              ],
            )
          ],
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register",
                style: TextStyle(
                    fontSize: 28,
                    color: colorExt.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Create a new account to start using the app",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 40,
              ),
              registerSteps[_currentStep],
            ],
          )),
    );
  }
}
