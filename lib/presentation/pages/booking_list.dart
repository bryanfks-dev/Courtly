import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/payment_status.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/presentation/widgets/booking_list/purchase_card.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [BookingList] is a page to show user's order history.
class BookingList extends StatelessWidget {
  BookingList({super.key});

  /// [_chipLabelList] is the list of sports that the user can choose from.
  /// The list is used to create a filter chip.
  final List<String> _chipLabelList =
      ["All"] + Sports.values.map((e) => e.label).toList();

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<String> _selectedChipNotifier = ValueNotifier("All");

  /// [_orderHistoryNotifier] is the list of order history.
  /// The list is used to show the order history.
  final ValueNotifier<List<dynamic>> _orderHistoryNotifier = ValueNotifier([1]);

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt = Theme.of(context).extension()!;

    return SafeArea(
      child: Container(
        color: colorExt.backgroundSecondary,
        child: SingleChildScrollView(
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
                      items: _chipLabelList,
                      selectedItem: _selectedChipNotifier),
                ),
              ),
              content: SizedBox(
                child: ValueListenableBuilder(
                    valueListenable: _orderHistoryNotifier,
                    builder:
                        (BuildContext context, List<dynamic> orderHistory, _) {
                      return ListView.separated(
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
                              const SizedBox(height: 5),
                          itemCount: orderHistory.length);
                    }),
              )),
        ),
      ),
    );
  }
}
