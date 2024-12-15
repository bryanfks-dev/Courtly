import 'package:flutter/material.dart';

/// [FilterChips] is a widget that displays a list of items that the user can
/// choose from.
class FilterChips extends StatelessWidget {
  const FilterChips(
      {super.key,
      required this.items,
      required this.selectedItem,
      required this.onSelected});

  /// [items] is the list of items that the user can choose from.
  final List<Widget> items;

  /// [selectedItem] is the selected item.
  final ValueNotifier<int> selectedItem;

  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedItem,
        builder: (BuildContext context, dynamic selectedChipIndex, _) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: ChoiceChip(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: items[i],
                      showCheckmark: false,
                      selected: selectedChipIndex == i,
                      onSelected: (bool selected) {
                        if (!selected) {
                          return;
                        }

                        // Set the selected chip
                        selectedItem.value = i;

                        // Call the onSelected callback
                        onSelected();
                      },
                    ),
                  )
                ]
              ],
            ),
          );
        });
  }
}
