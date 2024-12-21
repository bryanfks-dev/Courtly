import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/blocs/change_username_bloc.dart';
import 'package:courtly/presentation/blocs/events/profile_event.dart';
import 'package:courtly/presentation/blocs/profile_bloc.dart';
import 'package:courtly/presentation/blocs/states/change_username_state.dart';
import 'package:courtly/presentation/validators/change_username_validator.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ChangeUsernamePage] is page for /change-username route.
/// This page is used to change the username of the account.
class ChangeUsernamePage extends StatefulWidget {
  const ChangeUsernamePage({super.key});

  @override
  State<ChangeUsernamePage> createState() => _ChangeUsernamePage();
}

class _ChangeUsernamePage extends State<ChangeUsernamePage> {
  /// [_validator] is a validator for the change username form.
  final ChangeUsernameValidator _validator = ChangeUsernameValidator();

  /// [_usernameController] is a controller of username text input.
  final TextEditingController _usernameController = TextEditingController();

  /// [_errorTexts] is a map of error texts.
  final Map<String, String?> _errorTexts = {
    'username': null,
  };

  /// [_validateForm] is a method that validates the form.
  ///
  /// Returns [bool] if the form is valid.
  bool _validateForm() {
    setState(() {
      _errorTexts["username"] =
          _validator.validateUsername(username: _usernameController.text);
    });

    return _errorTexts["username"] == null;
  }

  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return Scaffold(
      backgroundColor: colorExt.background,
      body: SafeArea(
        child: BlocConsumer<ChangeUsernameBloc, ChangeUsernameState>(
            listener: (BuildContext context, ChangeUsernameState state) {
          // Show error message if state is error
          if (state is ChangeUsernameErrorState) {
            // Check if error message is a string
            if (state.errorMessage is String) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
              ));
            }

            // Check if error message is a map
            if (state.errorMessage is Map) {
              setState(() {
                _errorTexts["username"] = state.errorMessage['username']?.first;
              });
            }
          }

          if (state is ChangeUsernameSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Username changed successfully"),
            ));

            // Refresh auth state
            BlocProvider.of<ProfileBloc>(context).add(FetchProfileEvent());

            // Navigate to previous page
            Navigator.pop(context);
          }
        }, builder: (BuildContext context, ChangeUsernameState state) {
          // Show loading screen if state is loading
          if (state is ChangeUsernameLoadingState) {
            return LoadingScreen();
          }

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
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
                    child: Column(
                  children: [
                    TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          label: Text("Username"),
                          errorText: _errorTexts['username'],
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
                        // Validate form
                        if (!_validateForm()) {
                          return;
                        }

                        // Change username
                        context.read<ChangeUsernameBloc>().changeUsername(
                            newUsername: _usernameController.text);
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
                        // Navigate to previous page
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
          );
        }),
      ),
    );
  }
}
