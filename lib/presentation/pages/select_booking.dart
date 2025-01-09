import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/domain/entities/booking.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:courtly/presentation/blocs/select_booking_bloc.dart';
import 'package:courtly/presentation/blocs/states/select_booking_state.dart';
import 'package:courtly/presentation/pages/reviews.dart';
import 'package:courtly/presentation/providers/midtrans_provider.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:courtly/presentation/widgets/primary_button.dart';
import 'package:courtly/presentation/widgets/try_again_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

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
  /// The key is the date and the value is the set of selected boxes.
  final Map<String, Set<int>> _selectedBoxes = {};

  /// [_bookedBoxes] is a list of booked boxes.
  /// This list is used to store the booked boxes.
  final List<int> _bookedBoxes = [];

  /// [_gridBoxWidth] is the width of the grid box.
  final double _gridBoxWidth = 90;

  /// [_gridBoxHeight] is the height of the grid box.
  final double _gridBoxHeight = 56;

  /// [_timeColumnWidth] is the width of the time column.
  final double _timeColumnWidth = 70;

  /// [_selectedDate] is the selected date.
  DateTime _selectedDate = DateTime.now();

  /// [_courtsName] is the list of courts name.
  late List<String> _courtsName;

  /// [weekDays] is the list of week days.
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
    final int hourDiff = end.difference(start).inHours;

    return List.generate(hourDiff, (index) {
      final DateTime time = start.add(Duration(hours: index));

      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    });
  }

  /// [_timeSlots] is the list of time slots.
  late List<String> _timeSlots;

  /// [schedules] is a map that contains the schedules for each date.
  Map<String, List<List<bool>>> schedules = {};

  /// [_initializeSchedule] is a function that initializes the schedule for the selected date.
  ///
  /// Returns [void]
  void _initializeSchedule() {
    String dateKey = _formatDateKey(_selectedDate);

    schedules[dateKey] = List.generate(
      _timeSlots.length,
      (_) => List.generate(_courtsName.length, (_) => false),
    );
  }

  /// [_encodeBookingValue] is a function that encodes the booking value.
  ///
  /// Parameters:
  ///   - [timeIndex] is the index of the time.
  ///   - [courtIndex] is the index of the court.
  ///
  /// Returns an [int] that represents the encoded booking value.
  int _encodeBookingValue(int timeIndex, int courtIndex) {
    return courtIndex + timeIndex * _courtsName.length;
  }

  /// [_decodeBookingValue] is a function that decodes the booking value.
  ///
  /// Parameters:
  ///   - [value] is the value to be decoded.
  ///
  /// Returns a [BookingValueProps]
  BookingValueProps _decodeBookingValue(int value) {
    return BookingValueProps(
      time: _timeSlots[value ~/ _courtsName.length],
      courtId:
          (context.read<SelectBookingBloc>().state as SelectBookingFetchedState)
              .courts[value % _courtsName.length]
              .id,
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
    String dateKey = _formatDateKey(_selectedDate);

    // Initialize the selected boxes for the date if it doesn't exist
    _selectedBoxes.putIfAbsent(dateKey, () => {});

    // Get the current value
    final int currVal = _encodeBookingValue(timeIndex, courtIndex);

    setState(() {
      // Toggle the selection
      if (_selectedBoxes[dateKey]!.contains(currVal)) {
        _selectedBoxes[dateKey]!.remove(currVal);
      } else {
        _selectedBoxes[dateKey]!.add(currVal);
      }

      // Remove the date key if there is no selected box
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
    String dateKey = _formatDateKey(_selectedDate);

    return _selectedBoxes.containsKey(dateKey) &&
        _selectedBoxes[dateKey]!
            .contains(courtIndex + timeIndex * _courtsName.length);
  }

  /// [_isBooked] is a function that checks if a box is booked.
  ///
  /// Parameters:
  ///   - [courtIndex] is the index of the court.
  ///   - [timeIndex] is the index of the time.
  ///
  /// Returns a [bool] that indicates if the box is booked.
  bool _isBooked(int courtIndex, int timeIndex) {
    return _bookedBoxes.contains(_encodeBookingValue(timeIndex, courtIndex));
  }

  /// [_initBookedBoxes] is a function that initializes the booked boxes.
  ///
  /// Parameters:
  ///   - [bookings] is the list of bookings.
  ///
  /// Returns [void]
  void _initBookedBoxes(List<Booking> bookings) {
    // Clear the booked boxes
    _bookedBoxes.clear();

    // Encode the booking value
    for (Booking booking in bookings) {
      _bookedBoxes.add(_encodeBookingValue(
          _timeSlots.indexOf(DateFormat("HH:mm").format(booking.startTime)),
          _courtsName.indexOf(booking.court.name)));
    }
  }

  @override
  void initState() {
    super.initState();

    // Set the transaction finished callback
    MidtransProvider.midtransSDK
        ?.setTransactionFinishedCallback((TransactionResult result) {
      // Check if the transaction is successful
      if (result.transactionStatus == TransactionResultStatus.settlement) {
        Navigator.popUntil(context, (route) => route.isFirst);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Successfully booked the court!"),
        ));
      }
    });

    // Fetch the list of courts
    context.read<SelectBookingBloc>().getCourts(
        vendorId: widget.court.vendor.id,
        courtType: widget.court.type,
        date: _selectedDate);
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
      _selectedDate = newDate;
    });

    // Fetch the list of courts
    context.read<SelectBookingBloc>().getCourts(
        vendorId: widget.court.vendor.id,
        courtType: widget.court.type,
        date: _selectedDate);
  }

  /// [_formatWeekday] is a function that formats the weekday.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted weekday.
  String _formatWeekday(DateTime date) {
    return DateFormat("E").format(date);
  }

  /// [_formatMonth] is a function that formats the month.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted month.
  String _formatMonth(DateTime date) {
    return DateFormat("MMM").format(date);
  }

  /// [_getTitleWidget] is a function that generates the title widget for the table.
  ///
  /// Returns a [List] of [Widget]
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
  ///   - [timeIndex] the index of the row.
  ///
  /// Returns a [Widget]
  Widget _generateRightHandSideColumnRow(BuildContext context, int timeIndex) {
    return Row(
      children: List.generate(_courtsName.length, (int courtIndex) {
        // Get the hour and minute
        final List<String> hourMinute = _timeSlots[timeIndex].split(":");

        // Check if the date is selected
        final bool isBeforeDateTime = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                _selectedDate.day,
                int.parse(hourMinute[0]),
                int.parse(hourMinute[1]))
            .isBefore(DateTime.now());

        // Check if the box is booked
        final bool isBooked = _isBooked(courtIndex, timeIndex);

        // Check if the box is selected
        final bool isSelected = _isSelected(timeIndex, courtIndex);

        return GestureDetector(
          onTap: () {
            // Check if the box is booked
            if (isBooked || isBeforeDateTime) {
              return;
            }

            _toggleSelection(timeIndex, courtIndex);
          },
          child: Container(
            width: _gridBoxWidth,
            height: _gridBoxHeight,
            decoration: BoxDecoration(
              color: isBooked
                  ? _colorExt.outline
                  : isBeforeDateTime
                      ? _colorExt.highlight?.withOpacity(0.45)
                      : (isSelected ? _colorExt.primary : _colorExt.background),
              border: Border.all(color: _colorExt.outline!),
            ),
            child: (isSelected || isBooked)
                ? Center(
                    child: Text(
                      isBooked ? "Booked" : (isSelected ? "Selected" : ""),
                      style: TextStyle(
                        fontSize: 12,
                        color: isBooked
                            ? _colorExt.highlight
                            : _colorExt.background,
                      ),
                    ),
                  )
                : null,
          ),
        );
      }),
    );
  }

  /// [_buildPriceBox] adalah widget untuk menampilkan harga total berdasarkan kotak yang dipilih.
  ///
  /// Returns [Widget]
  Widget _buildPriceBox({required double courtPrice, required double appFee}) {
    // Get the date key
    final String dateKey = _formatDateKey(_selectedDate);

    // Get the selected count
    final int selectedCount = _selectedBoxes.containsKey(dateKey)
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
                "Total Order",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Rp ${moneyFormatter(amount: selectedCount * courtPrice + appFee)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Booking Price",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              Text(
                "Rp ${moneyFormatter(amount: selectedCount * courtPrice)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "App Fee",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              Text(
                "Rp ${moneyFormatter(amount: appFee)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            onPressed: () {
              final String date = _formatDateKey(_selectedDate);

              context.read<SelectBookingBloc>().submitBooking(
                  vendorId: widget.court.vendor.id,
                  date: date,
                  bookingDatas: _selectedBoxes[date]!
                      .map((e) => _decodeBookingValue(e))
                      .toSet());
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
        if (state is SelectBookingFetchedState) {
          // Initialize time slot
          _timeSlots = _generateTimeSlots(
              widget.court.vendor.openTime, widget.court.vendor.closeTime);

          // Initialize courts name
          _courtsName = state.courts.map((e) => e.name).toList();

          _initializeSchedule();

          _initBookedBoxes(state.bookings);
        }

        if (state is SelectBookingSubmittedState) {
          MidtransProvider.startPayment(paymentToken: state.paymentToken);
        }
      }, builder: (BuildContext context, SelectBookingState state) {
        // Check for states.
        if (state is SelectBookingErrorState) {
          return TryAgainScreen(
              onTryAgain: () => context.read<SelectBookingBloc>().getCourts(
                  vendorId: widget.court.vendor.id,
                  courtType: widget.court.type,
                  date: _selectedDate));
        }

        if (state is! SelectBookingFetchedState) {
          return const LoadingScreen();
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
                        // Navigate to the reviews page
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ReviewsPage(
                                  courtType: widget.court.type,
                                  vendorId: widget.court.vendor.id,
                                )));
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

                      bool isSelected = _selectedDate.day == date.day &&
                          _selectedDate.month == date.month;

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
              _buildPriceBox(
                  courtPrice: state.courts[0].price, appFee: state.fees.appFee),
            ],
          ),
        );
      }),
    );
  }
}
