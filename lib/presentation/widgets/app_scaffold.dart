import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/domain/entities/page_props.dart';
import 'package:courtly/presentation/pages/booking_list.dart';
import 'package:courtly/presentation/pages/home.dart';
import 'package:courtly/presentation/pages/profile.dart';
import 'package:courtly/presentation/widgets/bottom_navbar.dart';
import 'package:courtly/presentation/widgets/centered_app_bar.dart';
import 'package:courtly/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [AppScaffold] is the main application scaffold widget.
/// This widget is the root of the application.
class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
  });

  @override
  State<AppScaffold> createState() => _AppScaffold();
}

class _AppScaffold extends State<AppScaffold> {
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
    /// [colorExt] is the extension of the color theme.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

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
          backgroundColor: colorExt.background),
      PageProps(
          appBar: const CenteredAppBar(title: "Booking List"),
          body: BookingList(),
          icon: const HeroIcon(HeroIcons.calendarDays),
          selectedIcon: const HeroIcon(HeroIcons.calendarDays,
              style: HeroIconStyle.solid),
          label: "Booking List",
          backgroundColor: colorExt.backgroundSecondary),
      PageProps(
          appBar: const CenteredAppBar(title: "Profile"),
          body: const ProfilePage(),
          icon: const HeroIcon(HeroIcons.user),
          selectedIcon:
              const HeroIcon(HeroIcons.user, style: HeroIconStyle.solid),
          label: "Profile",
          backgroundColor: colorExt.backgroundSecondary)
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: pages[_selectedIndex].appBar,
      body: pages[_selectedIndex].body,
      backgroundColor: pages[_selectedIndex].backgroundColor,
      bottomNavigationBar: BottomNavbar(
          pages: pages, selectedIndex: _selectedIndex, changePage: _changePage),
    );
  }
}
