import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/data/providers/firebase_options.dart';
import 'package:courtly/domain/entities/page_props.dart';
import 'package:courtly/presentation/pages/home.dart';
import 'package:courtly/presentation/pages/login.dart';
import 'package:courtly/presentation/pages/booking_list.dart';
import 'package:courtly/presentation/pages/profile.dart';
import 'package:courtly/presentation/pages/register.dart';
import 'package:courtly/presentation/widgets/default_app_bar.dart';
import 'package:courtly/presentation/widgets/centered_app_bar.dart';
import 'package:courtly/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// [main] is the entry point of the application.
/// This function runs the application.
///
/// - Returns: void
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// [MyApp] is the main application widget.
/// This widget is the root of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  /// [_firebaseApp] is the future of Firebase app initialization.
  /// This is used to initialize Firebase app before running the application.
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// [_pages] is the list of pages that can be selected from
  /// bottom navigation bar.
  final List<PageProps> _pages = [
    PageProps(
        appBar: const DefaultAppBar(),
        body: HomePage(),
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home),
        label: "Home"),
    PageProps(
        appBar: const CenteredAppBar(title: "Booking List"),
        body: BookingList(),
        icon: const Icon(Icons.calendar_month_outlined),
        selectedIcon: const Icon(Icons.calendar_month),
        label: "Booking List"),
    PageProps(
        appBar: const CenteredAppBar(title: "Profile"),
        body: const ProfilePage(),
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: "Profile")
  ];

  /// [_selectedIndex] is the index of the selected page
  /// from bottom navigation bar.
  int _selectedIndex = 0;

  /// [_changePage] is a function to change page using bottom navigation bar.
  /// It takes [newIndex] as the index of the new page.
  ///
  /// - Parameters:
  ///   - [newIndex]: The index of the new page.
  ///
  /// - Returns: void
  void _changePage(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Courtly",
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode
            .light, // TODO: Change this after installing local storage dependency
        routes: {
          Routes.login: (context) => LoginPage(),
          Routes.register: (context) => const RegisterPage()
        },
        home: FutureBuilder(
            future: _firebaseApp,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
              // Show error message if Firebase initialization fails.
              if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text("Error initializing Firebase"),
                  ),
                );
              }

              // Show loading indicator while Firebase is initializing.
              if (snapshot.connectionState != ConnectionState.done) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              /// [colorExt] is the extension of the current color scheme.
              final AppColorsExtension colorExt =
                  Theme.of(context).extension<AppColorsExtension>()!;

              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: _pages[_selectedIndex].appBar,
                body: _pages[_selectedIndex].body,
                bottomNavigationBar: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    border: Border(
                      top: BorderSide(
                        color: colorExt.outline!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: colorExt.background!,
                      currentIndex: _selectedIndex,
                      items: [
                        for (int i = 0; i < _pages.length; i++) ...[
                          BottomNavigationBarItem(
                              icon: (_selectedIndex == i)
                                  ? (_pages[i].selectedIcon ?? _pages[i].icon)
                                  : _pages[i].icon,
                              label: _pages[i].label),
                        ]
                      ],
                      iconSize: 24,
                      selectedFontSize: 0,
                      unselectedFontSize: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      onTap: (int newIndex) {
                        if (_selectedIndex == newIndex) {
                          return;
                        }

                        // Change the page.
                        _changePage(newIndex);
                      },
                    ),
                  ),
                ),
              );
            }));
  }
}
