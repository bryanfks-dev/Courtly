import 'package:courtly/presentation/pages/home.dart';
import 'package:courtly/presentation/pages/login.dart';
import 'package:courtly/presentation/pages/profile.dart';
import 'package:courtly/presentation/pages/register.dart';
import 'package:courtly/presentation/widgets/default_app_bar.dart';
import 'package:courtly/presentation/widgets/centered_app_bar.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class PageProps {
  final dynamic appBar;
  final Widget body;
  final Icon icon;
  final Icon? selectedIcon;
  final String label;

  PageProps(
      {required this.appBar,
      required this.body,
      required this.icon,
      this.selectedIcon,
      required this.label});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  /// _pages is the list of pages that can be selected
  /// from bottom navigation bar.
  final List<PageProps> _pages = [
    PageProps(
        appBar: const DefaultAppBar(),
        body: const HomePage(),
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home),
        label: "Home"),
    PageProps(
        appBar: const CenteredAppBar(title: "Profile"),
        body: const ProfilePage(),
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: "Profile")
  ];

  /// _selectedIndex is the index of the selected page
  /// from bottom navigation bar.
  int _selectedIndex = 0;

  /// _changePage is a function to change page
  /// using bottom navigation bar.
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
        routes: {
          Routes.login: (context) => const LoginPage(),
          Routes.register: (context) => const RegisterPage()
        },
        home: Scaffold(
          appBar: _pages[_selectedIndex].appBar,
          body: _pages[_selectedIndex].body,
          bottomNavigationBar: SizedBox(
            height: 42,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey.shade500,
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
                selectedItemColor: Colors.red,
                onTap: (int newIndex) {
                  if (_selectedIndex == newIndex) {
                    return;
                  }

                  _changePage(newIndex);
                },
              ),
            ),
          ),
        ));
  }
}
