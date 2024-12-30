import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/create_order_dto.dart';
import 'package:courtly/data/dto/order_dto.dart';
import 'package:courtly/data/repository/api/order_repository.dart';
import 'package:courtly/domain/props/booking_value_props.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:courtly/domain/entities/order.dart';

/// [OrderUsecase] is the usecase for the order feature.
class OrderUsecase {
  /// [orderRepository] is the instance of the [OrderRepository].
  final OrderRepository orderRepository;

  OrderUsecase({
    required this.orderRepository,
  });

  /// [getOrders] is the method to get the orders.
  ///
  /// Returns a [Future] of [dartz.Either] of [Failure] or [List] of [Order].
  Future<dartz.Either<Failure, List<Order>>> getOrders(
      {String? courtType}) async {
    // Get the orders.
    final dartz.Either<Failure, List<OrderDTO>> res =
        await orderRepository.getOrders(courtType: courtType);

    // Return the orders.
    return res.fold((l) => dartz.left(l),
        (r) => dartz.right(r.map((e) => Order.fromDTO(e)).toList()));
  }

  /// [createOrder] is a method to create order.
  ///
  /// Parameters:
  ///   - [vendorId] is the id of the vendor.
  ///   - [date] is the date of the order.
  ///   - [paymentMethodApiValue] is the payment method.
  ///   - [bookingDatas] is the set of booking data.
  ///
  /// Returns a [Future] of [dartz.Either] a [Failure] or [String].
  Future<dartz.Either<Failure, String>> createOrder(
      {required int vendorId,
      required String date,
      required Set<BookingValueProps> bookingDatas}) async {
    /// [bookingDatasGroup] is a list of groupped booking data based on
    /// court id.
    final Map<int, List<BookingValueProps>> bookingDatasGroupped = {};

    // Group booking data by court id by looping through the booking data
    for (final bookingData in bookingDatas) {
      // Check if the court id is already in the list
      if (bookingDatasGroupped.containsKey(bookingData.courtId)) {
        bookingDatasGroupped[bookingData.courtId]!.add(bookingData);

        continue;
      }

      bookingDatasGroupped[bookingData.courtId] = [bookingData];
    }

    // Create DTO from props
    final CreateOrderDTO dto = CreateOrderDTO(
        date: date,
        vendorId: vendorId,
        bookings: bookingDatasGroupped
            .map((k, v) => MapEntry(
                k,
                CreateBookingsInnerDTO(
                    courtId: k, bookTimes: v.map((e) => e.time).toList())))
            .values
            .toList());

    // Create bookings from repository
    final dartz.Either<Failure, String> res =
        await orderRepository.createOrder(dto: dto);

    return res.fold((l) => dartz.left(l), (r) => dartz.Right(r));
  }
}
