import 'package:courtly/domain/entities/order.dart';

/// [OrdersState] is the abstract class that will be extended by the different states of the orders bloc.
abstract class OrdersState {}

/// [OrdersInitialState] is the initial state of the orders bloc.
/// This state will be used when the orders bloc is initialized.
class OrdersInitialState extends OrdersState {}

/// [OrdersLoadingState] is the loading state of the orders bloc.
/// This state will be used when the orders bloc is loading data.
class OrdersLoadingState extends OrdersState {}

/// [OrdersLoadedState] is the loaded state of the orders bloc.
/// This state will be used when the orders bloc has loaded data.
class OrdersLoadedState extends OrdersState {
  /// [orders] is the list of orderss.
  final List<Order> orders;

  OrdersLoadedState({
    required this.orders,
  });
}

/// [OrdersErrorState] is the error state of the orders bloc.
/// This state will be used when the orders bloc has encountered
/// an error.
class OrdersErrorState extends OrdersState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  OrdersErrorState({
    required this.errorMessage,
  });
}
