import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/core/utils/safe_access.dart';
import 'package:courtly/presentation/blocs/auth_bloc.dart';
import 'package:courtly/presentation/blocs/orders_bloc.dart';
import 'package:courtly/presentation/blocs/states/auth_state.dart';
import 'package:courtly/presentation/blocs/states/orders_state.dart';
import 'package:courtly/presentation/widgets/orders/purchase_card.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [OrdersPage] is a page to show user's order history.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPage();
}

class _OrdersPage extends State<OrdersPage> {
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

    // Fetch the orders.
    context.read<OrdersBloc>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return SafeArea(
      child: Container(
        color: colorExt.backgroundSecondary,
        child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (BuildContext context, OrdersState state) {
          // Show pop up if the state is error
          if (state is OrdersErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        }, builder: (BuildContext context, OrdersState state) {
          // Check if user is authenticated or if use doesn't
          // have any orders appointment
          if (context.read<AuthBloc>().state is UnauthenticatedState) {
            return Center(
                child: Text(
              "No Orders yet..",
              style: TextStyle(color: colorExt.highlight),
            ));
          }

          // Show loading screen if the state is not loaded
          if (state is! OrdersLoadedState) {
            return LoadingScreen();
          }

          return RefreshIndicator(
              onRefresh: () async {
                context.read<OrdersBloc>().getOrders(
                    courtType: listSafeAccess(
                            list: Sports.values,
                            index: _selectedChipNotifier.value - 1,
                            defaultValue: null)
                        ?.label);
              },
              color: colorExt.primary,
              backgroundColor: colorExt.background,
              child: SingleChildScrollView(
                child: StickyHeader(
                    header: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: colorExt.background,
                          border: Border(
                              top: BorderSide(
                                  width: 1, color: colorExt.outline!),
                              bottom: BorderSide(
                                  width: 1, color: colorExt.outline!))),
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: PAGE_PADDING_MOBILE),
                        child: FilterChips(
                          items: _chipLabelItems,
                          selectedItem: _selectedChipNotifier,
                          onSelected: () {
                            context.read<OrdersBloc>().getOrders(
                                courtType: listSafeAccess(
                                        list: Sports.values,
                                        index: _selectedChipNotifier.value - 1,
                                        defaultValue: null)
                                    ?.label);
                          },
                        ),
                      ),
                    ),
                    content: (state.orders.isEmpty)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(
                              child: Text(
                                "No Orders yet..",
                                style: TextStyle(color: colorExt.highlight),
                              ),
                            ),
                          )
                        : SizedBox(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return PurchaseCard(
                                      order: state.orders[index]);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10),
                                itemCount: state.orders.length),
                          )),
              ));
        }),
      ),
    );
  }
}
