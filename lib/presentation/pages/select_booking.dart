import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/domain/entities/vendor.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

/// [SelectBookingPage] is a [StatefulWidget] that displays the detail of a court.
/// This widget is used to display the detail of a court, including the schedule
class SelectBookingPage extends StatefulWidget {
  const SelectBookingPage(
      {super.key, required this.vendor, required this.courtType});

  /// [vendor] is the vendor of the court.
  final Vendor vendor;

  /// [courtType] is the type of the court.
  final String courtType;

  @override
  State<SelectBookingPage> createState() => _SelectBookingPage();
}

class _SelectBookingPage extends State<SelectBookingPage> {
  /// [__colorExt] is the extension of the color scheme of the app.
  late AppColorsExtension _colorExt;

  // late List<Widget> _moreMenus;
  Map<String, Set<int>> _selectedBoxes = {};

  /// [_gridBoxWidth] is the width of the grid box.
  final double _gridBoxWidth = 90;

  /// [_gridBoxHeight] is the height of the grid box.
  final double _gridBoxHeight = 56;

  /// [_timeColumnWidth] is the width of the time column.
  final double _timeColumnWidth = 70;

  DateTime selectedDate = DateTime.now();

  final List<String> courts = ['Court 1', 'Court 2', 'Court 3', 'Court 4'];

  final List<DateTime> weekDays =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  final List<String> timeSlots = [
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];

  // Schedule for each date (key = date, value = grid data)
  Map<String, List<List<bool>>> schedules = {};

  /// [_initializeSchedule] is a function that initializes the schedule for the selected date.
  void _initializeSchedule() {
    String dateKey = _formatDateKey(selectedDate);

    schedules[dateKey] = List.generate(
      timeSlots.length,
      (_) => List.generate(courts.length, (_) => false),
    );
  }

  void _toggleSelection(int timeIndex, int courtIndex) {
    String dateKey = _formatDateKey(selectedDate);
    _selectedBoxes.putIfAbsent(dateKey, () => {});

    setState(() {
      if (_selectedBoxes[dateKey]!
          .contains(courtIndex + timeIndex * courts.length)) {
        _selectedBoxes[dateKey]!.remove(courtIndex + timeIndex * courts.length);
      } else {
        _selectedBoxes[dateKey]!.add(courtIndex + timeIndex * courts.length);
      }

      // Jika semua kotak tidak dipilih, hapus kunci dari Map.
      if (_selectedBoxes[dateKey]!.isEmpty) {
        _selectedBoxes.remove(dateKey);
      }
    });
  }

  bool _isSelected(int timeIndex, int courtIndex) {
    String dateKey = _formatDateKey(selectedDate);
    return _selectedBoxes.containsKey(dateKey) &&
        _selectedBoxes[dateKey]!
            .contains(courtIndex + timeIndex * courts.length);
  }

  @override
  void initState() {
    super.initState();

    _initializeSchedule();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _colorExt = Theme.of(context).extension<AppColorsExtension>()!;
  }

  String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  /// [_onDateChanged] is a function that is called when the date is changed.
  /// This function will update the selected date and the schedule.
  ///
  /// Parameters:
  /// - [newDate]: The new date that is selected.
  ///
  /// Returns: [void]
  void _onDateChanged(DateTime newDate) {
    setState(() {
      // Update the selected date
      selectedDate = newDate;
    });
  }

  /// [_getTitleWidget] is a function that generates the title widget for the table.
  ///
  /// Returns: [List<Widget>]
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(label: 'Time', width: _timeColumnWidth),
      ...courts.map(
          (court) => _getTitleItemWidget(label: court, width: _gridBoxWidth)),
    ];
  }

  /// [_getTitleItemWidget] is a function that generates the title item widget for the table.
  ///
  /// Parameters:
  ///   - [label]: The label of the title item.
  ///   - [width]: The width of the title item.
  ///
  /// Returns: [Widget]
  Widget _getTitleItemWidget({required String label, required double width}) {
    return Container(
      width: width,
      height: 56,
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  /// [_generateFirstColumnRow] is a function that generates the first column row for the table.
  ///
  /// Parameters:
  ///   - [context]: The build context.
  ///   - [index]: The index of the row.
  ///
  /// Returns: [Widget]
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: _gridBoxWidth,
      height: _gridBoxHeight,
      alignment: Alignment.center,
      child: Text(timeSlots[index]),
    );
  }

  /// [_generateRightHandSideColumnRow] is a function that generates the right hand side column row for the table.
  /// This function generates the grid box for each court.
  ///
  /// Parameters:
  ///   - [context]: The build context.
  ///   - [index]: The index of the row.
  ///
  /// Returns: [Widget]
  Widget _generateRightHandSideColumnRow(BuildContext context, int timeIndex) {
    return Row(
      children: List.generate(courts.length, (courtIndex) {
        bool isSelected = _isSelected(timeIndex, courtIndex);

        return GestureDetector(
          onTap: () => _toggleSelection(timeIndex, courtIndex),
          child: Container(
            width: _gridBoxWidth,
            height: _gridBoxHeight,
            decoration: BoxDecoration(
              color: isSelected ? _colorExt.primary : _colorExt.background,
              border: Border.all(color: _colorExt.outline!),
            ),
            child: Center(
              child: Text(
                isSelected ? "Selected" : "",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      isSelected ? _colorExt.background : _colorExt.textPrimary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// [_buildPriceBox] adalah widget untuk menampilkan harga total berdasarkan kotak yang dipilih.
  ///
  /// Returns [Widget]
  Widget _buildPriceBox() {
    String dateKey = _formatDateKey(selectedDate);
    int selectedCount = _selectedBoxes.containsKey(dateKey)
        ? _selectedBoxes[dateKey]!.length
        : 0;

    if (selectedCount == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: PAGE_PADDING_MOBILE, vertical: 20),
      decoration: BoxDecoration(
        color: _colorExt.background,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        border: Border.all(color: _colorExt.outline!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Booking Price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Rp ${selectedCount * 20000}", // Harga per kotak, ganti sesuai kebutuhan.
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24), // Jarak antara total price dan tombol
          PrimaryButton(
            onPressed: () {
              // Return to previous page
              Navigator.pop(context);
            },
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size.fromHeight(0)),
            ),
            child: const Text("Confirm Booking",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorExt.background,
      appBar: const BackableCenteredAppBar(title: "Basketball Court"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lunggu Sport Centre",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 40,
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "Jl. Raya Karanglo No.84, Karanglo, Banjararum, Kec. Siantar pemantapan aselole jos awikwok",
                          style: TextStyle(
                            color: _colorExt.highlight,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  )),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.reviews);
                        },
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        child: HeroIcon(HeroIcons.star,
                            size: 20,
                            color: _colorExt.star,
                            style: HeroIconStyle.solid),
                      ),
                      const Text(
                        "4.3",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      HeroIcon(HeroIcons.chevronRight,
                          size: 20, color: _colorExt.highlight),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
              child: SizedBox(
                height: 78,
                width: double.maxFinite,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime date = weekDays[index];
                    bool isSelected = selectedDate.day == date.day &&
                        selectedDate.month == date.month;

                    return InkWell(
                      onTap: () {
                        _onDateChanged(date);
                      },
                      overlayColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      child: Column(
                        children: [
                          Text(
                            _formatWeekday(date),
                            style: TextStyle(
                              color: isSelected
                                  ? _colorExt.primary
                                  : _colorExt.highlight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? _colorExt.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: isSelected
                                      ? _colorExt.primary!
                                      : _colorExt.outline!,
                                )),
                            child: Text(
                              "${date.day} ${_formatMonth(date)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? _colorExt.background
                                    : _colorExt.highlight,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, _) =>
                      const SizedBox(width: 6),
                  itemCount: weekDays.length,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: _timeColumnWidth,
                  rightHandSideColumnWidth: courts.length * _gridBoxWidth,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  itemCount: timeSlots.length,
                  leftHandSideColBackgroundColor: _colorExt.background!,
                  rightHandSideColBackgroundColor: _colorExt.background!,
                ),
              ),
            ),
            _buildPriceBox(),
          ],
        ),
      ),
    );
  }

  String _formatWeekday(DateTime date) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    return days[date.weekday % 7];
  }

  String _formatMonth(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[date.month - 1];
  }
}
