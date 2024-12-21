import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/order.dart';
import 'package:courtly/domain/usecases/order_usecase.dart';
import 'package:courtly/presentation/blocs/states/orders_state.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_bloc/flutter_bloc.dart';

/// [OrdersBloc] is the bloc for the orders feature.
class OrdersBloc extends Cubit<OrdersState> {
  /// [orderUsecase] is the instance of the [OrderUsecase].
  final OrderUsecase orderUsecase;

  OrdersBloc({required this.orderUsecase}) : super(OrdersInitialState());

  /// [getOrders] is the method to get the orders.
  ///
  /// Returns a [Future] of [void].
  Future<void> getOrders({String? courtType}) async {
    emit(OrdersLoadingState());

    // Get the bookings.
    final dartz.Either<Failure, List<Order>> res =
        await orderUsecase.getOrders(courtType: courtType);

    // Check if the result is a failure.
    res.fold((l) => emit(OrdersErrorState(errorMessage: l.errorMessage)),
        (r) => emit(OrdersLoadedState(orders: r)));
  }
}
