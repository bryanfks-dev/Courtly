import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/presentation/widgets/filter_chips.dart';
import 'package:courtly/presentation/widgets/home/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

/// [HomePage] is the first screen that the user sees.
/// [HomePage] contains list of available courts.
class HomePage extends StatelessWidget {
  HomePage({super.key});

  /// [_chipLabelList] is the list of sports that the user can choose from.
  /// The list is used to create a filter chip.
  final List<String> _chipLabelList =
      ["All"] + Sports.values.map((e) => e.label).toList();

  /// [_selectedChipNotifier] is the selected chip via filter chips.
  final ValueNotifier<String> _selectedChipNotifier = ValueNotifier("All");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greetings
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, John Doe!",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Which court would you like to rent?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            StickyHeader(
                header: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children: [
                      FilterChips(
                          items: _chipLabelList,
                          selectedItem: _selectedChipNotifier),
                      const SizedBox(height: 10),
                      const SizedBox(
                        height: 42,
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: "Search vendor..",
                            prefixIcon: Icon(
                              Icons.search,
                              size: 22,
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                content: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return const CartCard(
                          imgUrl: "",
                          rating: 5.0,
                          sportType: Sports.badminton,
                          vendorName: "Unggul Sports Centre",
                          openTime: "09:00 AM",
                          closeTime: "09:00 PM",
                          address: "Jl. Blimbing Indah 03 No. 07");
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: 10))
          ],
        ),
      ),
    );
  }
}
