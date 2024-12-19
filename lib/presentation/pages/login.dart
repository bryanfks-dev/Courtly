import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/events/auth_event.dart';
import 'package:courtly/presentation/blocs/login_bloc.dart';
import 'package:courtly/presentation/blocs/states/login_state.dart';
import 'package:courtly/presentation/validators/login_form_validator.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

/// [LoginPage] is page for /login route.
/// This page is used to login into existing account.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  /// [_loginFormValidator] is the instance of the login form validator.
  final LoginFormValidator _loginFormValidator = LoginFormValidator();

  /// [_textInputControllers] is the map of text input keys.
  final Map<String, TextEditingController> _textInputControllers = {
    "username": TextEditingController(),
    "password": TextEditingController(),
  };

  /// [_errorTexts] is the map of error texts.
  final Map<String, String?> _errorTexts = {
    "username": null,
    "password": null,
  };

  /// [_obsecureTextNotifier] is the notifier for obsecure text.
  /// This notifier is used to toggle the password visibility.
  final ValueNotifier<bool> _obsecureTextNotifier = ValueNotifier(true);

  /// [_validateLoginForm] is the function to validate the login form.
  ///
  /// Returns [bool] indicates the form is valid.
  bool _validateLoginForm() {
    setState(() {
      _errorTexts["username"] = _loginFormValidator.validateUsername(
          username: _textInputControllers["username"]!.text);
      _errorTexts["password"] = _loginFormValidator.validatePassword(
          password: _textInputControllers["password"]!.text);
    });

    return _errorTexts["username"] == null && _errorTexts["password"] == null;
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return PopScope(
        onPopInvokedWithResult: (bool didPop, _) {
          // Check if the page is popped
          if (!didPop) {
            return;
          }

          // Dispatch the check auth event
          context.read<AuthBloc>().add(CheckAuthEvent());
        },
        child: Scaffold(
          backgroundColor: colorExt.background,
          body: SafeArea(
            child: BlocConsumer<LoginBloc, LoginState>(
                listener: (BuildContext context, LoginState state) {
              // Check the state
              if (state is LoginSuccessState) {
                // Navigate to home page
                Navigator.popUntil(context, (route) => route.isFirst);
              }

              if (state is LoginErrorState) {
                // Check if the error message is a string
                if (state.errorMessage is String) {
                  // Show the error message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                  ));
                }

                // Check if the error message is a map
                if (state.errorMessage is Map) {
                  _errorTexts["username"] =
                      state.errorMessage["username"]?.first;
                  _errorTexts["password"] =
                      state.errorMessage["password"]?.first;
                }
              }
            }, builder: (BuildContext context, LoginState state) {
              // Check if the state is loading
              if (state is LoginLoadingState) {
                return const Center(
                  child: LoadingScreen(),
                );
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
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
                        child: Column(
                      children: [
                        TextFormField(
                            controller: _textInputControllers["username"],
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              label: Text("Username"),
                              errorText: _errorTexts["username"],
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _obsecureTextNotifier,
                            builder:
                                (BuildContext context, bool obsecureText, _) {
                              return TextFormField(
                                controller: _textInputControllers["password"],
                                style: const TextStyle(fontSize: 14),
                                obscureText: obsecureText,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  label: const Text("Password"),
                                  errorText: _errorTexts["password"],
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  suffixIcon: IconButton(
                                    icon: HeroIcon((obsecureText)
                                        ? HeroIcons.eyeSlash
                                        : HeroIcons.eye),
                                    iconSize: 16,
                                    onPressed: () {
                                      _obsecureTextNotifier.value =
                                          !obsecureText;
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
                            // Validate the login form
                            if (!_validateLoginForm()) {
                              return;
                            }

                            // Dispatch the login event
                            context.read<LoginBloc>().login(
                                username:
                                    _textInputControllers["username"]!.text,
                                password:
                                    _textInputControllers["password"]!.text);
                          },
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(
                                const Size.fromHeight(0)),
                          ),
                          child: const Text("Login"),
                        ),
                        const SizedBox(height: 10),
                        SecondaryButton(
                          onPressed: () {
                            // Navigate to register page
                            Navigator.pushReplacementNamed(
                                context, Routes.register);
                          },
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(
                                const Size.fromHeight(0)),
                          ),
                          child: const Text("I'm new here"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
