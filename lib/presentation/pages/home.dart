import 'package:courtly/core/enums/sports.dart';
import 'package:courtly/core/utils/utils.dart';
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

  /// [_selectedChipIndexNotifier] is the index of the selected chip.
  /// The index is used to determine which sport is selected.
  final ValueNotifier<int> _selectedChipIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greetings
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, John Doe!",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      "Which court you would like to rent?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Previous Rent",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Soccer Field 1",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            Text("Unggul Sport Centre",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Rp. ${moneyFormatter(amount: 100000)}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              MaterialButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  textColor: Colors.red,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  child: const Text("Rent again",
                                      style: TextStyle(fontSize: 13)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                StickyHeader(
                    header: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: _selectedChipIndexNotifier,
                              builder: (BuildContext context,
                                  int selectedChipIndex, _) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int i = 0;
                                          i < _chipLabelList.length;
                                          i++) ...[
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: ChoiceChip(
                                            label: Text(_chipLabelList[i],
                                                style: const TextStyle(
                                                    fontSize: 12)),
                                            labelStyle: TextStyle(
                                                color: selectedChipIndex == i
                                                    ? Colors.white
                                                    : Colors.black87),
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) {
                                              if (selectedChipIndex != i) {
                                                return Colors.grey.shade300;
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
                                              _selectedChipIndexNotifier.value =
                                                  i;
                                            },
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                );
                              }),
                          const SizedBox(height: 10),
                          const SizedBox(
                            height: 42,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Search court..",
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 18,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 14),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    content: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("Court ${index + 1}"),
                            subtitle: Text("Unggul Sport Centre"),
                            trailing: Text("Rp 100.000"),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: 10))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
