import 'package:courtly/core/config/app_themes.dart';
import 'package:courtly/data/repository/api/booking_repository.dart';
import 'package:courtly/data/repository/api/court_repository.dart';
import 'package:courtly/data/repository/api/login_repository.dart';
import 'package:courtly/data/repository/api/logout_repository.dart';
import 'package:courtly/data/repository/api/order_repository.dart';
import 'package:courtly/data/repository/api/register_repository.dart';
import 'package:courtly/data/repository/api/review_repository.dart';
import 'package:courtly/data/repository/api/user_repository.dart';
import 'package:courtly/data/repository/storage/theme_repository.dart';
import 'package:courtly/data/repository/storage/token_repository.dart';
import 'package:courtly/domain/usecases/auth_usecase.dart';
import 'package:courtly/domain/usecases/booking_usecase.dart';
import 'package:courtly/domain/usecases/court_usecase.dart';
import 'package:courtly/domain/usecases/login_usecase.dart';
import 'package:courtly/domain/usecases/logout_usecase.dart';
import 'package:courtly/domain/usecases/order_usecase.dart';
import 'package:courtly/domain/usecases/register_usecase.dart';
import 'package:courtly/domain/usecases/review_usecase.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/orders_bloc.dart';
import 'package:courtly/presentation/blocs/events/auth_event.dart';
import 'package:courtly/presentation/blocs/events/profile_event.dart';
import 'package:courtly/presentation/blocs/home_bloc.dart';
import 'package:courtly/presentation/blocs/login_bloc.dart';
import 'package:courtly/presentation/blocs/logout_bloc.dart';
import 'package:courtly/presentation/blocs/profile_bloc.dart';
import 'package:courtly/presentation/blocs/register_bloc.dart';
import 'package:courtly/presentation/blocs/reviews_bloc.dart';
import 'package:courtly/presentation/blocs/select_booking_bloc.dart';
import 'package:courtly/presentation/pages/change_password.dart';
import 'package:courtly/presentation/pages/change_username.dart';
import 'package:courtly/presentation/pages/choose_payment.dart';
import 'package:courtly/presentation/pages/login.dart';
import 'package:courtly/presentation/pages/payment_detail.dart';
import 'package:courtly/presentation/pages/register.dart';
import 'package:courtly/presentation/pages/write_review.dart';
import 'package:courtly/presentation/providers/theme_provider.dart';
import 'package:courtly/presentation/widgets/app_scaffold.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// [main] is the entry point of the application.
/// This function runs the application.
///
/// Returns [void]
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              authUsecase: AuthUsecase(tokenRepository: TokenRepository()),
            )..add(CheckAuthEvent()),
          ),
          BlocProvider(
              create: (BuildContext context) => RegisterBloc(
                  registerUsecase: RegisterUsecase(
                      registerRepository: RegisterRepository()))),
          BlocProvider(
              create: (BuildContext context) => LoginBloc(
                  loginUsecase: LoginUsecase(
                      loginRepository: LoginRepository(),
                      tokenRepository: TokenRepository()))),
          BlocProvider(
              create: (BuildContext context) => HomeBloc(
                  userUsecase: UserUsecase(userRepository: UserRepository()),
                  courtUsecase:
                      CourtUsecase(courtRepository: CourtRepository()))),
          BlocProvider(
              create: (BuildContext context) => SelectBookingBloc(
                  courtUsecase:
                      CourtUsecase(courtRepository: CourtRepository()),
                  bookingUsecase:
                      BookingUsecase(bookingRepository: BookingRepository()))),
          BlocProvider(
              create: (BuildContext context) => ReviewsBloc(
                  reviewUsecase:
                      ReviewUsecase(reviewRepository: ReviewRepository()))),
          BlocProvider(
              create: (BuildContext context) => OrdersBloc(
                  orderUsecase:
                      OrderUsecase(orderRepository: OrderRepository()))),
          BlocProvider(
              create: (BuildContext context) => ProfileBloc(
                  userUsecase: UserUsecase(userRepository: UserRepository()))
                ..add(FetchProfileEvent())),
          BlocProvider(
            create: (BuildContext context) => LoginBloc(
              loginUsecase: LoginUsecase(
                loginRepository: LoginRepository(),
                tokenRepository: TokenRepository(),
              ),
            ),
          ),
          BlocProvider(
              create: (BuildContext context) => LogoutBloc(
                  logoutUsecase: LogoutUsecase(
                      logoutRepository: LogoutRepository(),
                      tokenRepository: TokenRepository())))
        ],
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(ThemeRepository()),
          child: Consumer<ThemeProvider>(
            builder: (BuildContext context, ThemeProvider themeProvider, _) {
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
                    Routes.paymentDetail: (context) =>
                        const PaymentDetailPage(),
                    Routes.choosePayment: (context) => ChoosePaymentPage(),
                    Routes.changeUsername: (context) => ChangeUsernamePage(),
                    Routes.changePassword: (context) =>
                        const ChangePasswordPage(),
                  },
                  home: AppScaffold());
            },
          ),
        ));
  }
}
