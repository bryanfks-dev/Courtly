import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/presentation/pages/login.dart';
import 'package:courtly/presentation/pages/payment_detail.dart';
import 'package:courtly/presentation/pages/register.dart';
import 'package:courtly/presentation/pages/reviews.dart';
import 'package:courtly/presentation/pages/write_review.dart';
import 'package:courtly/presentation/widgets/app_scaffold.dart';
import 'package:courtly/routes/routes.dart';
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
          Routes.register: (context) => const RegisterPage(),
          Routes.writeReview: (context) => WriteReviewPage(),
          Routes.reviews: (context) => ReviewsPage(),
          Routes.paymentDetail: (context) => const PaymentDetail(),
        },
        home: AppScaffold());
  }
}
