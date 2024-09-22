import 'package:courtly/domain/entities/forms.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';

/// LoginPage is page for /login route.
/// This page is used to login into existing account.
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  /// _formKey is the key for the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  /// _data is the login form data.
  /// This data is used to store the login form contents.
  final LoginFormData _data = LoginFormData(
    username: "",
    password: "",
  );

  /// _textInputKeys is the map of text input keys.
  final Map<String, TextEditingController> _textInputKeys = {
    "username": TextEditingController(),
    "password": TextEditingController(),
  };

  /// _obsecureTextNotifier is the notifier for obsecure text.
  final ValueNotifier<bool> _obsecureTextNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Login into your existing account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _textInputKeys["username"],
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            label: Text("Username"),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelStyle: TextStyle(fontSize: 14),
                            floatingLabelStyle: TextStyle(
                              color: Colors.red,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 14),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _obsecureTextNotifier,
                          builder: (context, bool obsecureText, _) {
                            return TextFormField(
                              controller: _textInputKeys["password"],
                              obscureText: obsecureText,
                              enableSuggestions: false,
                              autocorrect: false,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelStyle: const TextStyle(fontSize: 14),
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.red,
                                ),
                                label: const Text("Password"),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 14),
                                suffixIcon: IconButton(
                                  icon: Icon((obsecureText)
                                      ? Icons.visibility_off
                                      : Icons.visibility),
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
                    child: const Text("Login",
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  SecondaryButton(
                      onPressed: () {
                        // Navigate to register page
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: const Text("I'm new here",
                          style: TextStyle(fontSize: 14))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
