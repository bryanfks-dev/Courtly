import 'package:courtly/domain/entities/order_detail.dart';

/// [OrderDetailState] is the abstract class that will be extended by the order
/// detail states.
abstract class OrderDetailState {}

/// [OrderDetailInitialState] is the initial state of the order detail.
/// This state will be emitted when the order detail bloc is initialized.
class OrderDetailInitialState extends OrderDetailState {}

/// [OrderDetailLoadingState] is the loading state of the order detail.
/// This state will be emitted when the order detail is being loaded.
class OrderDetailLoadingState extends OrderDetailState {}

class OrderDetailLoadedState extends OrderDetailState {
  /// [order] is the order detail.
  final OrderDetail orderDetail;

  OrderDetailLoadedState({required this.orderDetail});
}

/// [OrderDetailErrorState] is the error state of the order detail.
/// This state will be emitted when an error occurs while loading the order
/// detail.
class OrderDetailErrorState extends OrderDetailState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  OrderDetailErrorState({required this.errorMessage});
}
