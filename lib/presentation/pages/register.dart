import 'package:courtly/domain/entities/register_form_data.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';

/// RegisterPage is page for /register route.
/// This page is used to register a new account.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  /// _currentStep is the current register step.
  int _currentStep = 0;

  /// _data is the register form data.
  /// This data is used to store the register form contents.
  final RegisterFormData _data = RegisterFormData(
    username: "",
    password: "",
    confirmPassword: "",
    phoneNumber: "",
  );

  /// _nextStep is a function to go to the next step.
  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  /// _previousStep is a function to go to the previous step.
  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// registerSteps is the list of register steps.
    /// This list is used to store the register form contents.
    final List<Widget> registerSteps = [
      Form(
        child: Column(
          children: [
            TextFormField(
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text("Username"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelStyle: TextStyle(fontSize: 14),
                  floatingLabelStyle: TextStyle(
                    color: Colors.red,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 14),
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
                  child: const Text("Next",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                SecondaryButton(
                    onPressed: () {
                      // Navigate to login page
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: const Text("I already have an account",
                        style: TextStyle(fontSize: 14))),
              ],
            )
          ],
        ),
      ),
      Form(
        child: Column(
          children: [
            TextFormField(
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text("Phone Number"),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelStyle: TextStyle(fontSize: 14),
                  floatingLabelStyle: TextStyle(
                    color: Colors.red,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 14),
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
                  child: const Text("Next",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                SecondaryButton(
                    onPressed: () {
                      // Move to previous step
                      _previousStep();
                    },
                    child: const Text("Back", style: TextStyle(fontSize: 14))),
              ],
            )
          ],
        ),
      ),
      Form(
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      label: Text("Password"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelStyle: TextStyle(fontSize: 14),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      label: Text("Confirm Password"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelStyle: TextStyle(fontSize: 14),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 14),
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
                  child: const Text("Create Account",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                SecondaryButton(
                    onPressed: () {
                      // Move to previous step
                      _previousStep();
                    },
                    child: const Text("Back", style: TextStyle(fontSize: 14))),
              ],
            )
          ],
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Create a new account to start using the app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 40,
                ),
                registerSteps[_currentStep],
              ],
            )),
      ),
    );
  }
}
