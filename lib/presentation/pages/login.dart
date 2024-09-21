import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';

/// LoginPage is page for /login route.
/// This page is used to login into existing account.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            label: Text("Username"),
                            labelStyle: TextStyle(
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 14),
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          label: const Text("Password"),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 14),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility_off),
                            iconSize: 16,
                            onPressed: () {},
                          ),
                        ),
                      )
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
                      child: const Text("Register",
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
