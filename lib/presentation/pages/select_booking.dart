import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/presentation/blocs/select_booking_bloc.dart';
import 'package:courtly/presentation/blocs/states/select_booking_state.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

/// [SelectBookingPage] is a [StatefulWidget] that displays the detail of a court.
/// This widget is used to display the detail of a court, including the schedule
class SelectBookingPage extends StatefulWidget {
  const SelectBookingPage({super.key, required this.court});

  /// [court] is the court that is being displayed.
  final Court court;

  @override
  State<SelectBookingPage> createState() => _SelectBookingPage();
}

class _SelectBookingPage extends State<SelectBookingPage> {
  /// [_colorExt] is the extension of the color scheme of the app.
  late AppColorsExtension _colorExt;

  /// [_selectedBoxes] is a map that contains the selected boxes.
  Map<String, Set<int>> _selectedBoxes = {};

  /// [_gridBoxWidth] is the width of the grid box.
  final double _gridBoxWidth = 90;

  /// [_gridBoxHeight] is the height of the grid box.
  final double _gridBoxHeight = 56;

  /// [_timeColumnWidth] is the width of the time column.
  final double _timeColumnWidth = 70;

  DateTime selectedDate = DateTime.now();

  /// [_courtsName] is the list of courts name.
  late List<String> _courtsName;

  final List<DateTime> weekDays =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  /// [_generateTimeSlots] is a function that generates the time slots between the start and end time.
  ///
  /// Parameters:
  ///   - [start] is the start time.
  ///   - [end] is the end time.
  ///
  /// Returns a [List] of [String]
  List<String> _generateTimeSlots(DateTime start, DateTime end) {
    final int hourDiff = end.difference(start).inHours + 1;

    return List.generate(hourDiff, (index) {
      final DateTime time = start.add(Duration(hours: index));

      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    });
  }

  /// [_timeSlots] is the list of time slots.
  late List<String> _timeSlots;

  // Schedule for each date (key = date, value = grid data)
  Map<String, List<List<bool>>> schedules = {};

  /// [_initializeSchedule] is a function that initializes the schedule for the selected date.
  ///
  /// Returns [void]
  void _initializeSchedule() {
    String dateKey = _formatDateKey(selectedDate);

    schedules[dateKey] = List.generate(
      _timeSlots.length,
      (_) => List.generate(_courtsName.length, (_) => false),
    );
  }

  /// [_toggleSelection] is a function that toggles the selection of a box.
  ///
  /// Parameters:
  ///   - [timeIndex] is the index of the time.
  ///   - [courtIndex] is the index of the court.
  ///
  /// Returns [void]
  void _toggleSelection(int timeIndex, int courtIndex) {
    // Get the date key
    String dateKey = _formatDateKey(selectedDate);

    // Initialize the selected boxes for the date if it doesn't exist
    _selectedBoxes.putIfAbsent(dateKey, () => {});

    setState(() {
      if (_selectedBoxes[dateKey]!
          .contains(courtIndex + timeIndex * _courtsName.length)) {
        _selectedBoxes[dateKey]!
            .remove(courtIndex + timeIndex * _courtsName.length);
      } else {
        _selectedBoxes[dateKey]!
            .add(courtIndex + timeIndex * _courtsName.length);
      }

      // Jika semua kotak tidak dipilih, hapus kunci dari Map.
      if (_selectedBoxes[dateKey]!.isEmpty) {
        _selectedBoxes.remove(dateKey);
      }
    });
  }

  /// [_isSelected] is a function that checks if a box is selected.
  ///
  /// Parameters:
  ///   - [timeIndex] is the index of the time.
  ///   - [courtIndex] is the index of the court.
  ///
  /// Returns a [bool] that indicates if the box is selected.
  bool _isSelected(int timeIndex, int courtIndex) {
    String dateKey = _formatDateKey(selectedDate);
    return _selectedBoxes.containsKey(dateKey) &&
        _selectedBoxes[dateKey]!
            .contains(courtIndex + timeIndex * _courtsName.length);
  }

  @override
  void initState() {
    super.initState();

    // Fetch the list of courts
    context.read<SelectBookingBloc>().getCourts(
        vendorId: widget.court.vendor.id, courtType: widget.court.type);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _colorExt = Theme.of(context).extension<AppColorsExtension>()!;
  }

  /// [_formatDateKey] is a function that formats the date key.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted date key.
  String _formatDateKey(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  /// [_onDateChanged] is a function that is called when the date is changed.
  /// This function will update the selected date and the schedule.
  ///
  /// Parameters:
  ///   - [newDate] the new date that is selected.
  ///
  /// Returns: [void]
  void _onDateChanged(DateTime newDate) {
    setState(() {
      // Update the selected date
      selectedDate = newDate;
    });
  }

  /// [_formatWeekday] is a function that formats the weekday.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted weekday.
  String _formatWeekday(DateTime date) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    return days[date.weekday % 7];
  }

  /// [_formatMonth] is a function that formats the month.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted month.
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

  /// [_getTitleWidget] is a function that generates the title widget for the table.
  ///
  /// Returns: [List<Widget>]
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(label: 'Time', width: _timeColumnWidth),
      ..._courtsName.map(
          (court) => _getTitleItemWidget(label: court, width: _gridBoxWidth)),
    ];
  }

  /// [_getTitleItemWidget] is a function that generates the title item widget for the table.
  ///
  /// Parameters:
  ///   - [label] the label of the title item.
  ///   - [width] the width of the title item.
  ///
  /// Returns a [Widget]
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
  ///   - [context] the build context.
  ///   - [index] the index of the row.
  ///
  /// Returns: [Widget]
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: _gridBoxWidth,
      height: _gridBoxHeight,
      alignment: Alignment.center,
      child: Text(_timeSlots[index]),
    );
  }

  /// [_generateRightHandSideColumnRow] is a function that generates the right hand side column row for the table.
  /// This function generates the grid box for each court.
  ///
  /// Parameters:
  ///   - [context] the build context.
  ///   - [index] the index of the row.
  ///
  /// Returns: [Widget]
  Widget _generateRightHandSideColumnRow(BuildContext context, int timeIndex) {
    return Row(
      children: List.generate(_courtsName.length, (courtIndex) {
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

    // Check if there is no selected box
    if (selectedCount == 0) {
      return const SizedBox(height: PAGE_PADDING_MOBILE);
    }

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
                "Rp ${moneyFormatter(amount: selectedCount * widget.court.price)}", // Harga per kotak, ganti sesuai kebutuhan.
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
      appBar: BackableCenteredAppBar(title: "${widget.court.type} Court"),
      body: BlocConsumer<SelectBookingBloc, SelectBookingState>(
          listener: (BuildContext context, SelectBookingState state) {
        // Show error message if the state is an error state
        if (state is SelectBookingErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }

        // Initialize the schedule if the state is loaded
        if (state is SelectBookingLoadedState) {
          // Initialize time slot
          _timeSlots = _generateTimeSlots(
              widget.court.vendor.openTime, widget.court.vendor.closeTime);

          // Initialize courts name
          _courtsName = state.courts.map((e) => e.name).toList();

          _initializeSchedule();
        }
      }, builder: (BuildContext context, SelectBookingState state) {
        // Check if the state is not loaded yet
        if (state is! SelectBookingLoadedState) {
          return const Center(child: LoadingScreen());
        }

        return SafeArea(
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
                        Text(
                          widget.court.vendor.name,
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
                            widget.court.vendor.address,
                            style: TextStyle(
                              color: _colorExt.highlight,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    )),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.reviews);
                      },
                      overlayColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      child: Row(
                        children: [
                          HeroIcon(HeroIcons.star,
                              size: 20,
                              color: _colorExt.star,
                              style: HeroIconStyle.solid),
                          Text(
                            widget.court.rating.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          HeroIcon(HeroIcons.chevronRight,
                              size: 20, color: _colorExt.highlight),
                        ],
                      ),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: PAGE_PADDING_MOBILE),
                  child: HorizontalDataTable(
                    leftHandSideColumnWidth: _timeColumnWidth,
                    rightHandSideColumnWidth:
                        _courtsName.length * _gridBoxWidth,
                    isFixedHeader: true,
                    headerWidgets: _getTitleWidget(),
                    leftSideItemBuilder: _generateFirstColumnRow,
                    rightSideItemBuilder: _generateRightHandSideColumnRow,
                    itemCount: _timeSlots.length,
                    leftHandSideColBackgroundColor: _colorExt.background!,
                    rightHandSideColBackgroundColor: _colorExt.background!,
                  ),
                ),
              ),
              _buildPriceBox(),
            ],
          ),
        );
      }),
    );
  }
}
