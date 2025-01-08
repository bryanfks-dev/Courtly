import 'dart:io';

import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/change_profile_picture_bloc.dart';
import 'package:courtly/presentation/blocs/events/auth_event.dart';
import 'package:courtly/presentation/blocs/events/profile_event.dart';
import 'package:courtly/presentation/blocs/logout_bloc.dart';
import 'package:courtly/presentation/blocs/profile_bloc.dart';
import 'package:courtly/presentation/blocs/states/change_profile_picture_state.dart';
import 'package:courtly/presentation/blocs/states/logout_state.dart';
import 'package:courtly/presentation/blocs/states/profile_state.dart';
import 'package:courtly/presentation/providers/theme_provider.dart';
import 'package:courtly/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu_card.dart';
import 'package:courtly/presentation/widgets/profile/profile_menu_toggle.dart';
import 'package:courtly/presentation/widgets/secondary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/// [LoggedInProfile] is profile page content when user is logged in.
class LoggedInProfile extends StatefulWidget {
  const LoggedInProfile({super.key});

  @override
  State<LoggedInProfile> createState() => _LoggedInProfile();
}

class _LoggedInProfile extends State<LoggedInProfile> {
  /// [_image] is the image xfile.
  XFile? _image;

  /// [_pickImage] is a Future function that picks an image from the device.
  ///
  /// Returns [Future] of [XFile]
  Future<XFile?> _pickImage() async {
    // Create an image picker
    final ImagePicker picker = ImagePicker();

    // Pick an image from gallery
    return await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  void initState() {
    super.initState();

    // Check if the vendor data is not loaded
    if (context.read<ProfileBloc>().state is! ProfileLoadedState) {
      // Fetch the vendor data
      context.read<ProfileBloc>().add(FetchProfileEvent());
    }
  }

  /// [_openLogoutModal] is the function to open the logout modal.
  /// This function will open the modal to confirm the logout action.
  ///
  /// Parameters:
  ///   - [context] is the context of the application.
  ///   - [colorExt] is the extension of the color scheme of the application.
  ///
  /// Returns [void]
  void _openLogoutModal(BuildContext context, AppColorsExtension colorExt) {
    // Open the change profile modal.
    showBottomModalSheet(
        context,
        BlocConsumer<LogoutBloc, LogoutState>(
            listener: (BuildContext context, LogoutState logoutState) {
          // Handle the state
          if (logoutState is LogoutSuccessState) {
            // Close the modal
            Navigator.pop(context);

            context.read<AuthBloc>().add(CheckAuthEvent());
          }

          if (logoutState is LogoutErrorState) {
            // Close the modal
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(logoutState.errorMessage)));
          }
        }, builder: (BuildContext context, LogoutState state) {
          // Check the state of the logout.
          if (state is LogoutLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Text.rich(
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorExt.textPrimary),
                  TextSpan(text: "You are about to ", children: [
                    TextSpan(
                        text: "log out",
                        style: TextStyle(color: colorExt.danger)),
                    const TextSpan(text: ", confirm to proceed.")
                  ])),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                              BorderSide(width: 1, color: colorExt.highlight!)),
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(0))),
                      child: Text(
                        "I changed my mind",
                        style: TextStyle(
                            color: colorExt.highlight,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                      onPressed: () {
                        // Dispatch the logout event.
                        context.read<LogoutBloc>().logout();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(colorExt.danger),
                          minimumSize: WidgetStateProperty.all(
                              const Size.fromHeight(0))),
                      child: const Text("Log me out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)))
                ],
              )
            ],
          );
        }));
  }

  /// [_openChangeProfilePictureModal] is the function to open the change
  /// profile picture modal.
  ///
  /// Parameters:
  ///   - [context] is the context of the application.
  ///   - [colorExt] is the extension of the color scheme of the application.
  ///
  /// Returns [void]
  void _openChangeProfilePictureModal(
      BuildContext context, AppColorsExtension colorExt) {
    // Open the change profile modal.
    showBottomModalSheet(
        context,
        BlocConsumer<ChangeProfilePictureBloc, ChangeProfilePictureState>(
            listener: (BuildContext context,
                ChangeProfilePictureState changeProfilePictureState) {
          // Handle the state
          if (changeProfilePictureState is ChangeProfilePictureErrorState) {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(changeProfilePictureState.errorMessage)));
          }

          if (changeProfilePictureState is ChangeProfilePictureSuccessState) {
            // Close the modal
            Navigator.pop(context);

            context.read<ProfileBloc>().add(FetchProfileEvent());
          }
        }, builder: (BuildContext context,
                ChangeProfilePictureState changeProfilePictureState) {
          // Check the state of the logout.
          if (changeProfilePictureState is ChangeProfilePictureLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pick an Image",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorExt.textPrimary)),
              const SizedBox(
                height: 30,
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                return Center(
                  child: GestureDetector(
                    onTap: () async {
                      // Pick an image
                      final XFile? result = await _pickImage();

                      // Check if the image is null
                      if (result == null) {
                        return;
                      }

                      setModalState(() {
                        _image = result;
                      });
                    },
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          image: DecorationImage(
                              image: Image.file(File(_image!.path)).image,
                              fit: BoxFit.cover),
                          color: colorExt.outline),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                      onPressed: () {
                        _image = null;

                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                              BorderSide(width: 1, color: colorExt.highlight!)),
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(0))),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: colorExt.highlight,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                      onPressed: () async {
                        // Check if the image is null
                        if (_image == null) {
                          return;
                        }

                        // Dispatch the change profile picture event.
                        context
                            .read<ChangeProfilePictureBloc>()
                            .changeProfilePicture(
                                imageFile: File(_image!.path));
                      },
                      style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                              const Size.fromHeight(0))),
                      child: const Text("Change",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)))
                ],
              )
            ],
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [themeProvider] is the provider of the theme of the application.
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    /// [darkMode] is the notifier for the dark mode.
    final ValueNotifier<bool> darkMode =
        ValueNotifier(themeProvider.currentTheme == AppThemes.dark);

    /// [toggleDarkMode] is the function to toggle the dark mode.
    ///
    /// Parameters:
    ///   - [value] is the value of the toggle.
    ///
    /// Returns [void]
    void toggleDarkMode(bool value) {
      if (value) {
        themeProvider.setDarkTheme();
      } else {
        themeProvider.setLightTheme();
      }

      darkMode.value = value;
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
      // Check the state of the profile.
      if (state is! ProfileLoadedState) {
        return LoadingScreen();
      }

      return SafeArea(
          child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(FetchProfileEvent());
              },
              color: colorExt.primary,
              backgroundColor: colorExt.background,
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: PAGE_PADDING_MOBILE,
                        right: PAGE_PADDING_MOBILE,
                        bottom: 20),
                    color: colorExt.background,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Pick an image
                            _image = await _pickImage();

                            // Check if the image is null
                            if (_image == null) {
                              return;
                            }

                            // Check if the context is not mounted
                            if (!context.mounted) {
                              return;
                            }

                            // Open the change profile picture modal.
                            _openChangeProfilePictureModal(context, colorExt);
                          },
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: colorExt.outline,
                                image: state.user.profilePictureUrl.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            "${state.user.profilePictureUrl}?timestamp=${DateTime.now().millisecondsSinceEpoch}"),
                                        fit: BoxFit.cover)
                                    : null),
                            child: state.user.profilePictureUrl.isEmpty
                                ? HeroIcon(
                                    HeroIcons.userCircle,
                                    color: colorExt.highlight,
                                    style: HeroIconStyle.solid,
                                    size: 64,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.user.username,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("+${state.user.phoneNumber}",
                                style: TextStyle(
                                    fontSize: 12, color: colorExt.highlight))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileMenuCard(title: "Personal Information", menus: [
                    ProfileMenu(
                        iconData: HeroIcons.atSymbol,
                        title: "Change Username",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.changeUsername);
                        }),
                    ProfileMenu(
                        iconData: HeroIcons.lockClosed,
                        title: "Change Password",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.changePassword);
                        }),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileMenuCard(title: "Preference", menus: [
                    ProfileMenuToggle(
                        iconData: HeroIcons.moon,
                        title: "Dark Mode",
                        defaultValue: darkMode.value,
                        onChanged: toggleDarkMode),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileMenu(
                      iconData: HeroIcons.informationCircle,
                      title: "About Us",
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.aboutUs)),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileMenu(
                      iconData: HeroIcons.arrowRightStartOnRectangle,
                      title: "Log Out",
                      onTap: () => _openLogoutModal(context, colorExt)),
                ],
              )));
    });
  }
}
