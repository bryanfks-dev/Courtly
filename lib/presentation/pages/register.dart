import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/blocs/register_bloc.dart';
import 'package:courtly/presentation/blocs/states/register_state.dart';
import 'package:courtly/presentation/validators/register_form_validator.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [RegisterPage] is page for /register route.
/// This page is used to register a new account.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  /// [_registerFormValidator] is the register form validator.
  final RegisterFormValidator _registerFormValidator = RegisterFormValidator();

  /// [_currentStep] is the current register step.
  int _currentStep = 0;

  /// [_textInputControllers] is the register form controllers.
  /// This controllers is used to store the register form controllers.
  final Map<String, TextEditingController> _textInputControllers = {
    "username": TextEditingController(),
    "phoneNumber": TextEditingController(),
    "password": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };

  /// [_errorTexts] is the register form error texts.
  final Map<String, String?> _errorTexts = {
    "username": null,
    "phoneNumber": null,
    "password": null,
    "confirmPassword": null,
  };

  /// [_toUsernameForm] is a function to go to the username form.
  ///
  /// Returns [void]
  void _toUsernameForm() {
    setState(() {
      _currentStep = 0;
    });
  }

  /// [_toPhoneNumberForm] is a function to go to the phone number form.
  ///
  /// Returns [void]
  void _toPhoneNumberForm() {
    setState(() {
      _currentStep = 1;
    });
  }

  /// [_toPasswordForm] is a function to go to the password form.
  ///
  /// Returns [void]
  void _toPasswordForm() {
    setState(() {
      _currentStep = 2;
    });
  }

  /// [_validateUsernameForm] is a function to validate the username form.
  ///
  /// Returns [bool]
  bool _validateUsernameForm() {
    setState(() {
      // Validate username
      _errorTexts["username"] = _registerFormValidator.validateUsername(
          username: _textInputControllers["username"]!.text);
    });

    return _errorTexts["username"] == null;
  }

  /// [_validatePhoneNumberForm] is a function to validate the phone number form.
  ///
  /// Returns [bool]
  bool _validatePhoneNumberForm() {
    setState(() {
      // Validate phone number
      _errorTexts["phoneNumber"] = _registerFormValidator.validatePhoneNumber(
          phoneNumber: _textInputControllers["phoneNumber"]!.text);
    });

    return _errorTexts["phoneNumber"] == null;
  }

  /// [_validatePasswordsForm] is a function to validate the passwords form.
  ///
  /// Returns [bool]
  bool _validatePasswordsForm() {
    setState(() {
      // Validate password
      _errorTexts["password"] = _registerFormValidator.validatePassword(
          password: _textInputControllers["password"]!.text);

      // Validate confirm password
      _errorTexts["confirmPassword"] =
          _registerFormValidator.validateConfirmPassword(
              password: _textInputControllers["password"]!.text,
              confirmPassword: _textInputControllers["confirmPassword"]!.text);
    });

    return _errorTexts["password"] == null &&
        _errorTexts["confirmPassword"] == null;
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the color extension of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    // Initialize the register bloc
    final RegisterBloc controller = BlocProvider.of<RegisterBloc>(context);

    /// [registerSteps] is the list of register steps.
    final List<Widget> registerSteps = [
      Form(
        child: Column(
          children: [
            TextFormField(
                controller: _textInputControllers["username"],
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  label: Text("Username"),
                  errorText: _errorTexts["username"],
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
                    // Validate username
                    if (!_validateUsernameForm()) {
                      return;
                    }

                    // Move to next step
                    _toPhoneNumberForm();
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Next"),
                ),
                const SizedBox(
                  height: 10,
                ),
                SecondaryButton(
                    onPressed: () {
                      // Navigate to login page
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all(const Size.fromHeight(0)),
                    ),
                    child: const Text("I already have an account")),
              ],
            )
          ],
        ),
      ),
      Form(
        child: Column(
          children: [
            TextFormField(
                controller: _textInputControllers["phoneNumber"],
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text("Phone Number"),
                  prefixText: "+62",
                  errorText: _errorTexts["phoneNumber"],
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
                    // Validate phone number
                    if (!_validatePhoneNumberForm()) {
                      return;
                    }

                    // Move to next step
                    _toPasswordForm();
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Next"),
                ),
                const SizedBox(
                  height: 10,
                ),
                SecondaryButton(
                    onPressed: () {
                      // Move to previous step
                      _toUsernameForm();
                    },
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all(const Size.fromHeight(0)),
                    ),
                    child: const Text("Back")),
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
                    controller: _textInputControllers["password"],
                    style: const TextStyle(fontSize: 14),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      label: Text("Password"),
                      errorText: _errorTexts["password"],
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
                    decoration: InputDecoration(
                      label: Text("Confirm Password"),
                      errorText: _errorTexts["confirmPassword"],
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
                  onPressed: () {
                    // Validate passwords
                    if (!_validatePasswordsForm()) {
                      return;
                    }

                    // Register the user
                    controller.register(
                        username: _textInputControllers["username"]!.text,
                        phoneNumber:
                            "62${_textInputControllers['phoneNumber']!.text}",
                        password: _textInputControllers["password"]!.text,
                        confirmPassword:
                            _textInputControllers["confirmPassword"]!.text);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size.fromHeight(0)),
                  ),
                  child: const Text("Create Account"),
                ),
                const SizedBox(
                  height: 10,
                ),
                SecondaryButton(
                    onPressed: () {
                      // Move to previous step
                      _toPhoneNumberForm();
                    },
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all(const Size.fromHeight(0)),
                    ),
                    child: const Text("Back")),
              ],
            )
          ],
        ),
      ),
    ];

    return BlocListener<RegisterBloc, RegisterState>(
        listener: (BuildContext context, RegisterState state) {
          // Check the state
          if (state is RegisterSuccessState) {
            // Navigate to login page
            Navigator.popAndPushNamed(context, Routes.login);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Registration successful!"),
            ));
          }

          if (state is RegisterErrorState) {
            if (state.errorMessage is String) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
              ));
            }

            if (state.errorMessage is Map) {
              setState(() {
                _errorTexts["username"] = state.errorMessage["username"]?.first;

                _errorTexts["phoneNumber"] =
                    state.errorMessage["phone_number"]?.first;

                _errorTexts["password"] = state.errorMessage["password"]?.first;

                _errorTexts["confirmPassword"] =
                    state.errorMessage["confirm_password"]?.first;

                if (_errorTexts["username"] != null) {
                  _toUsernameForm();
                } else if (_errorTexts["phoneNumber"] != null) {
                  _toPhoneNumberForm();
                } else if (_errorTexts["password"] != null ||
                    _errorTexts["confirmPassword"] != null) {
                  _toPasswordForm();
                }
              });
            }
          }
        },
        child: Scaffold(
            backgroundColor: colorExt.background,
            body: SafeArea(
              child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (BuildContext context, RegisterState state) {
                // Check the state
                if (state is RegisterLoadingState) {
                  return Center(child: LoadingScreen());
                }

                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PAGE_PADDING_MOBILE),
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
                    ));
              }),
            )));
  }
}
