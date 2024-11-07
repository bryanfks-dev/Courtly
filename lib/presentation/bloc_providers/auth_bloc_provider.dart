import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/presentation/blocs/auth/auth_bloc.dart';
import 'package:courtly/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlocProvider extends StatefulWidget {
  /// [guardedWidget] is a widget to be shown when user is authenticated.
  final Widget guardedWidget;

  /// [unguardedWidget] is a widget to be shown when user is not authenticated.
  final Widget unguardedWidget;

  const AuthBlocProvider(
      {super.key, required this.guardedWidget, required this.unguardedWidget});

  @override
  State<AuthBlocProvider> createState() => _AuthBlocProvider();
}

class _AuthBlocProvider extends State<AuthBlocProvider> {
  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an extension to get the app colors.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthAuthenticated) {
          return widget.guardedWidget;
        } else if (state is AuthUnauthenticated) {
          return widget.unguardedWidget;
        }

        return Container(
            color: colorExt.background,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
