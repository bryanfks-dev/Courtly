import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/core/utils/money_formatter.dart';
import 'package:courtly/presentation/blocs/order_detail_bloc.dart';
import 'package:courtly/presentation/blocs/states/order_detail_state.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

/// [OrderDetailPage] is a page to show payment details.
class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.orderId});

  /// [orderId] is the id of the order.
  final int orderId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();

    // Fetch the order detail.
    context.read<OrderDetailBloc>().getOrderDetail(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an extension of the app.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colorExt.background,
      appBar: const BackableCenteredAppBar(title: "Order Detail"),
      body: SafeArea(
          child: BlocConsumer<OrderDetailBloc, OrderDetailState>(
              listener: (BuildContext context, OrderDetailState state) {
        // Check the state
        if (state is OrderDetailErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }
      }, builder: (BuildContext context, OrderDetailState state) {
        // Check for state
        if (state is! OrderDetailLoadedState) {
          return LoadingScreen();
        }

        // Create date formatter
        final DateFormat dateFormatter = DateFormat("MMM dd, yyy");

        // Create time formatter
        final DateFormat timeFormatter = DateFormat("HH:mm");

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: PAGE_PADDING_MOBILE * 1.5),
            child: Column(
              children: [
                Text(state.orderDetail.bookings[0].court.vendor.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorExt.textPrimary,
                    )),
                Text(state.orderDetail.bookings[0].court.vendor.address,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorExt.textPrimary,
                    )),
                const SizedBox(height: 20),
                Text.rich(
                  style: TextStyle(
                    fontSize: 12,
                    color: colorExt.textPrimary,
                  ),
                  TextSpan(text: "Order ID: ", children: [
                    TextSpan(
                        text: state.orderDetail.midtransOrderId,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                HeroIcon(
                  HeroIcons.checkCircle,
                  color: colorExt.success,
                  style: HeroIconStyle.solid,
                  size: MediaQuery.of(context).size.width / 1.5,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorExt.textPrimary,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Court Type",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  state.orderDetail.bookings[0].court.type,
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Date",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  dateFormatter
                                      .format(state.orderDetail.orderDate),
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Booking Time Period",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    for (var i
                                        in state.orderDetail.bookings) ...[
                                      Text(
                                        "${timeFormatter.format(i.startTime)} - ${timeFormatter.format(i.endTime)} / ${i.court.name}",
                                        style: TextStyle(
                                            color: colorExt.textPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      )
                                    ]
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorExt.textPrimary,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Created Date",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  DateFormat("MMM dd, yyy")
                                      .format(state.orderDetail.createdDate),
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Price",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Rp ${moneyFormatter(amount: state.orderDetail.price)}",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Application Service",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Rp ${moneyFormatter(amount: state.orderDetail.appFee)}",
                                  style: TextStyle(
                                      color: colorExt.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: colorExt.outline!,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Total",
                        style: TextStyle(
                            color: colorExt.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp ${moneyFormatter(amount: state.orderDetail.price + state.orderDetail.appFee)}",
                        style: TextStyle(
                            color: colorExt.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      })),
    );
  }
}
