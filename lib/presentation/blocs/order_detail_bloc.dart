import 'package:courtly/domain/usecases/order_usecase.dart';
import 'package:courtly/presentation/blocs/states/order_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailBloc extends Cubit<OrderDetailState> {
  /// [orderUsecase] is the instance of the [OrderUsecase].
  final OrderUsecase orderUsecase;

  OrderDetailBloc({required this.orderUsecase})
      : super(OrderDetailInitialState());

  /// [getOrderDetail] is a method that fetches the order detail.
  /// 
  /// Parameters:
  ///   - [orderId] is the id of the order.
  /// 
  /// Returns a [Future] of [void].
  Future<void> getOrderDetail({required int orderId}) async {
    emit(OrderDetailLoadingState());

    // Fetch the order detail.
    final res = await orderUsecase.getOrderDetail(orderId: orderId);

    // Handle the result.
    res.fold((l) => emit(OrderDetailErrorState(errorMessage: l.errorMessage)),
        (r) => emit(OrderDetailLoadedState(orderDetail: r)));
  }
}
