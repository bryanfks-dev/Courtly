import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/core/utils/safe_access.dart';
import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/home_bloc.dart';
import 'package:courtly/presentation/blocs/states/auth_state.dart';
import 'package:courtly/presentation/blocs/states/home_state.dart';
import 'package:courtly/presentation/pages/select_booking.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:courtly/presentation/widgets/home/court_card.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [HomePage] is the first screen that the user sees.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  /// [_searchController] is the controller for the search field.
  final TextEditingController _searchController = TextEditingController();

  /// [_chipLabelItems] is the items of filter chip.
  final List<Widget> _chipLabelItems =
      [const Text("All")] + Sports.values.map((e) => Text(e.label)).toList();

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    // Check if the user is authenticated.
    if (BlocProvider.of<AuthBloc>(context, listen: false).state
        is AuthenticatedState) {
      context.read<HomeBloc>().fetch();

      return;
    }

    context.read<HomeBloc>().fetchCourtsOnly();
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the app.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return SafeArea(
      child: BlocConsumer<HomeBloc, HomeState>(
          listener: (BuildContext context, HomeState state) {
        // Show pop up if the state is error
        if (state is HomeErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }
      }, builder: (BuildContext context, HomeState state) {
        // Show loading screen if the state is loading.
        if (state is! HomeLoadedState) {
          return const Center(child: LoadingScreen());
        }

        return RefreshIndicator(
            onRefresh: () async {
              await context.read<HomeBloc>().fetch();
            },
            color: colorExt.primary,
            backgroundColor: colorExt.background,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greetings
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: PAGE_PADDING_MOBILE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${state.user?.username ?? "Guest"}!",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Which court would you like to rent?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  StickyHeader(
                      header: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: colorExt.background,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: PAGE_PADDING_MOBILE),
                              child: FilterChips(
                                  items: _chipLabelItems,
                                  selectedItem: _selectedChipNotifier,
                                  onSelected: () {
                                    context.read<HomeBloc>().fetchCourtsOnly(
                                        courtType: listSafeAccess(
                                                list: Sports.values,
                                                index: _selectedChipNotifier
                                                        .value -
                                                    1,
                                                defaultValue: null)
                                            ?.label,
                                        vendorName: _searchController.text);
                                  }),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: PAGE_PADDING_MOBILE),
                              child: TextField(
                                controller: _searchController,
                                style: TextStyle(fontSize: 14),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  hintText: "Search vendor..",
                                  prefixIcon: HeroIcon(
                                    HeroIcons.magnifyingGlass,
                                    size: 20,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (value) {
                                  context.read<HomeBloc>().fetchCourtsOnly(
                                      courtType: listSafeAccess(
                                              list: Sports.values,
                                              index:
                                                  _selectedChipNotifier.value -
                                                      1,
                                              defaultValue: null)
                                          ?.label,
                                      vendorName: value);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      content: BlocBuilder<HomeBloc, HomeState>(
                          builder: (BuildContext context, HomeState state) {
                        // Show loading screen if the state is loading.
                        if (state is! HomeLoadedState) {
                          return LoadingScreen();
                        }

                        // Show no courts found if the list is empty.
                        if (state.courts.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Text(
                                "No courts found",
                                style: TextStyle(color: colorExt.highlight),
                              ),
                            ),
                          );
                        }

                        return Container(
                          padding: const EdgeInsets.only(
                              left: PAGE_PADDING_MOBILE,
                              right: PAGE_PADDING_MOBILE,
                              bottom: 10),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return CourtCard(
                                  data: state.courts[index],
                                  onTap: () {
                                    if (context.read<AuthBloc>().state
                                        is UnauthenticatedState) {
                                      // Navigate to the login page.
                                      Navigator.of(context)
                                          .pushNamed(Routes.login);

                                      return;
                                    }

                                    // Navigate to the select booking page.
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SelectBookingPage(
                                          court: state.courts[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 10),
                              itemCount: state.courts.length),
                        );
                      }))
                ],
              ),
            ));
      }),
    );
  }
}
