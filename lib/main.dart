import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/domain/entities/page_props.dart';
import 'package:courtly/presentation/pages/home.dart';
import 'package:courtly/presentation/pages/introduction.dart';
import 'package:courtly/presentation/pages/login.dart';
import 'package:courtly/presentation/pages/booking_list.dart';
import 'package:courtly/presentation/pages/profile.dart';
import 'package:courtly/presentation/pages/register.dart';
import 'package:courtly/presentation/pages/write_review.dart';
import 'package:courtly/presentation/widgets/bottom_navbar.dart';
import 'package:courtly/presentation/widgets/default_app_bar.dart';
import 'package:courtly/presentation/widgets/centered_app_bar.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

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
    /// [pages] is the list of pages that can be selected from
    /// bottom navigation bar.
    final List<PageProps> pages = [
      PageProps(
          appBar: const DefaultAppBar(),
          body: HomePage(),
          icon: const HeroIcon(HeroIcons.home),
          selectedIcon:
              const HeroIcon(HeroIcons.home, style: HeroIconStyle.solid),
          label: "Home",
          backgroundColor: Colors.white),
      PageProps(
          appBar: const CenteredAppBar(title: "Booking List"),
          body: BookingList(),
          icon: const HeroIcon(HeroIcons.calendarDays),
          selectedIcon: const HeroIcon(HeroIcons.calendarDays,
              style: HeroIconStyle.solid),
          label: "Booking List",
          backgroundColor: Colors.white),
      PageProps(
          appBar: const CenteredAppBar(title: "Profile"),
          body: const ProfilePage(),
          icon: const HeroIcon(HeroIcons.user),
          selectedIcon:
              const HeroIcon(HeroIcons.user, style: HeroIconStyle.solid),
          label: "Profile",
          backgroundColor: Colors.white)
    ];

    return MaterialApp(
        title: "Courtly",
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode
            .light, // TODO: Change this after installing local storage dependency
        routes: {
          Routes.login: (context) => LoginPage(),
          Routes.register: (context) => const RegisterPage(),
          Routes.writeReview: (context) => const WriteReviewPage()
        },
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: pages[_selectedIndex].appBar,
          body: pages[_selectedIndex].body,
          backgroundColor: pages[_selectedIndex].backgroundColor,
          bottomNavigationBar: BottomNavbar(
              pages: pages,
              selectedIndex: _selectedIndex,
              changePage: _changePage),
        )
        );
  }
}
