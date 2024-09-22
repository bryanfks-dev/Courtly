import 'package:courtly/core/enums/sports.dart';
import 'package:flutter/material.dart';

/// [OrderHistoryPage] is a page to show user's order history.
class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({super.key});

  /// [_chipLabelList] is the list of sports that the user can choose from.
  /// The list is used to create a filter chip.
  final List<String> _chipLabelList =
      ["All"] + Sports.values.map((e) => e.label).toList();

  /// [_selectedChipIndexNotifier] is the index of the selected chip.
  /// The index is used to determine which sport is selected.
  final ValueNotifier<int> _selectedChipIndexNotifier = ValueNotifier(0);

  /// [_orderHistoryNotifier] is the list of order history.
  /// The list is used to show the order history.
  final ValueNotifier<List<dynamic>> _orderHistoryNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: _selectedChipIndexNotifier,
              builder: (BuildContext context, int selectedChipIndex, _) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < _chipLabelList.length; i++) ...[
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            label: Text(_chipLabelList[i],
                                style: const TextStyle(fontSize: 12)),
                            labelStyle: TextStyle(
                                color: selectedChipIndex == i
                                    ? Colors.white
                                    : Colors.black87),
                            color: MaterialStateColor.resolveWith((states) {
                              if (selectedChipIndex != i) {
                                return Colors.transparent;
                              }

                              return Colors.red;
                            }),
                            showCheckmark: false,
                            selected: selectedChipIndex == i,
                            onSelected: (bool selected) {
                              if (!selected) {
                                return;
                              }

                              // Set the selected chip index.
                              _selectedChipIndexNotifier.value = i;
                            },
                          ),
                        )
                      ]
                    ],
                  ),
                );
              }),
          const SizedBox(height: 20),
          ValueListenableBuilder(
              valueListenable: _orderHistoryNotifier,
              builder: (BuildContext context, List<dynamic> orderHistory, _) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            "Order #${orderHistory[index]["orderNumber"]}"),
                        subtitle:
                            Text("Total: ${orderHistory[index]["total"]}"),
                        trailing: Text(orderHistory[index]["status"]),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Spacer(),
                    itemCount: orderHistory.length);
              })
        ],
      ),
    );
  }
}
