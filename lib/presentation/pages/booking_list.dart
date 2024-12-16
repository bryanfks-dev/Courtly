import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/payment_status.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/booking_bloc.dart';
import 'package:courtly/presentation/blocs/states/auth_state.dart';
import 'package:courtly/presentation/blocs/states/booking_state.dart';
import 'package:courtly/presentation/widgets/booking_list/purchase_card.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [BookingList] is a page to show user's order history.
class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingList();
}

class _BookingList extends State<BookingList> {
  /// [_chipLabelItems] is the items of filter chip.
  final List<Widget> _chipLabelItems =
      [const Text("All")] + Sports.values.map((e) => Text(e.label)).toList();

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<int> _selectedChipNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    // Check if the user is authenticated.
    if (BlocProvider.of<AuthBloc>(context).state is! AuthenticatedState) {
      return;
    }

    // Fetch the bookings.
    context.read<BookingBloc>().getBookings();
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return SafeArea(
      child: Container(
        color: colorExt.backgroundSecondary,
        child: BlocConsumer<BookingBloc, BookingState>(
            listener: (BuildContext context, BookingState state) {
          // Show pop up if the state is error
          if (state is BookingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        }, builder: (BuildContext context, BookingState state) {
          // Check if user is authenticated or if use doesn't
          // have any bookings appointment
          if (BlocProvider.of<AuthBloc>(context).state
                  is UnauthenticatedState ||
              (state is BookingLoadedState && state.bookings.isEmpty)) {
            return Center(
                child: Text(
              "No Bookings yet..",
              style: TextStyle(color: colorExt.highlight),
            ));
          }

          // Show loading screen if the state is not loaded
          if (state is! BookingLoadedState) {
            return Center(child: LoadingScreen());
          }

          return SingleChildScrollView(
            child: StickyHeader(
                header: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: colorExt.background,
                      border: Border(
                          top: BorderSide(width: 1, color: colorExt.outline!),
                          bottom:
                              BorderSide(width: 1, color: colorExt.outline!))),
                  child: Container(
                    margin: const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                    child: FilterChips(
                      items: _chipLabelItems,
                      selectedItem: _selectedChipNotifier,
                      onSelected: () {},
                    ),
                  ),
                ),
                content: SizedBox(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return PurchaseCard(
                            purchaseDate: DateTime.now(),
                            sportType: Sports.badminton,
                            vendorName: "Unggul Sports Centre",
                            price: 100000,
                            paymentStatus: PaymentStatus.success);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                      itemCount: state.bookings.length),
                )),
          );
        }),
      ),
    );
  }
}
