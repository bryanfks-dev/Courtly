import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/order_dto.dart';
import 'package:courtly/data/repository/api/order_repository.dart';
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
}
