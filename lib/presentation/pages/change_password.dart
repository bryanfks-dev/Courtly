import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/blocs/change_password_bloc.dart';
import 'package:courtly/presentation/blocs/states/change_password_state.dart';
import 'package:courtly/presentation/validators/change_password_validator.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ChangePasswordPage] is a stateful widget that is used to change the user's password.
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  /// [_validator] is the change password form validator.
  final ChangePasswordFormValidator _validator = ChangePasswordFormValidator();

  /// [_textInputControllers] is the register form controllers.
  /// This controllers is used to store the register form controllers.
  final Map<String, TextEditingController> _textInputControllers = {
    "oldPassword": TextEditingController(),
    "newPassword": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };

  /// [_errorTexts] is the error texts for the register form.
  /// This is used to store the error texts for the register form.
  final Map<String, String?> _errorTexts = {
    "oldPassword": null,
    "newPassword": null,
    "confirmPassword": null,
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

  /// [_validateVerifyPasswordForm] is a function to validate the verify password form.
  ///
  /// Returns a [bool]
  bool _validateVerifyPasswordForm() {
    setState(() {
      // Validate old password
      _errorTexts["oldPassword"] = _validator.validateOldPassword(
          oldPassword: _textInputControllers["oldPassword"]!.text);
    });

    return _errorTexts["oldPassword"] == null;
  }

  /// [_validateChangePasswordForm] is a function to validate the change password form.
  ///
  /// Returns a [bool]
  bool _validateChangePasswordForm() {
    setState(() {
      // Validate new password
      _errorTexts["newPassword"] = _validator.validateNewPassword(
          newPassword: _textInputControllers["newPassword"]!.text);

      // Validate confirm password
      _errorTexts["confirmPassword"] = _validator.validateConfirmPassword(
          newPassword: _textInputControllers["newPassword"]!.text,
          confirmPassword: _textInputControllers["confirmPassword"]!.text);
    });

    return _errorTexts["newPassword"] == null &&
        _errorTexts["confirmPassword"] == null;
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose all text input controllers
    for (final v in _textInputControllers.values) {
      v.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the color extension of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [changePasswordSteps] is the list of steps for changing password.
    /// This list is used to store the steps of changing password.
    final List<Widget> changePasswordSteps = [
      BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (BuildContext context, ChangePasswordState state) {
        return Column(
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
              child: Column(
                children: [
                  TextFormField(
                      controller: _textInputControllers["oldPassword"],
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        label: Text("Password"),
                        errorText: _errorTexts["oldPassword"],
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
                          // Validate the form
                          if (!_validateVerifyPasswordForm()) {
                            return;
                          }

                          context.read<ChangePasswordBloc>().verifyPassword(
                              password:
                                  _textInputControllers["oldPassword"]!.text);
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
                            minimumSize: WidgetStateProperty.all(
                                const Size.fromHeight(0)),
                          ),
                          child: const Text("Cancel")),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }),
      BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (BuildContext context, ChangePasswordState state) {
        return Column(
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
                          decoration: InputDecoration(
                            label: Text("New Password"),
                            errorText: _errorTexts["newPassword"],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
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
                          decoration: InputDecoration(
                            label: Text("Confirm Password"),
                            errorText: _errorTexts["confirmPassword"],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      PrimaryButton(
                        onPressed: () {
                          // Validate the form
                          if (!_validateChangePasswordForm()) {
                            return;
                          }

                          // Change the password
                          context.read<ChangePasswordBloc>().changePassword(
                              oldPassword:
                                  _textInputControllers["oldPassword"]!.text,
                              newPassword:
                                  _textInputControllers["newPassword"]!.text,
                              confirmPassword:
                                  _textInputControllers["confirmPassword"]!
                                      .text);
                        },
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
                            minimumSize: WidgetStateProperty.all(
                                const Size.fromHeight(0)),
                          ),
                          child: const Text("Cancel")),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      })
    ];

    return Scaffold(
        backgroundColor: colorExt.background,
        body: SafeArea(
            child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (BuildContext context, ChangePasswordState state) {
          // Check the state
          if (state is ChangePasswordErrorState) {
            // Check if error message is a string
            if (state.errorMessage is String) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
              ));
            }

            // Check if error message is a map
            if (state.errorMessage is Map) {
              // Set error texts
              setState(() {
                _errorTexts["oldPassword"] =
                    state.errorMessage["old_password"]?.first;
                _errorTexts["newPassword"] =
                    state.errorMessage["new_password"]?.first;
                _errorTexts["confirmPassword"] =
                    state.errorMessage["confirm_password"]?.first;
              });
            }
          }

          if (state is ChangePasswordVerifiedState) {
            _nextStep();
          }

          if (state is ChangePasswordSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        }, builder: (BuildContext context, ChangePasswordState state) {
          // Check if the state is verifying or changing password
          if (state is ChangePasswordVerifyingState ||
              state is ChangePasswordChangingState) {
            return LoadingScreen();
          }

          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
              child: changePasswordSteps[_currentStep]);
        })));
  }
}
