/// [SelectedPaymentState] is the abstract class that will be extended by the
/// states of the selected payment.
abstract class SelectedPaymentState {}

/// [SelectedPaymentInitialState] is the initial state of the selected payment.
/// This state will be used to initialize the selected payment.
class SelectedPaymentInitialState extends SelectedPaymentState {}

/// [SelectedPaymentLoadingState] is the state when the selected payment is
/// loading.
/// This state will be used to show the loading indicator.
class SelectedPaymentLoadingState extends SelectedPaymentState {}

/// [SelectedPaymentErrorState] is the state when an error occurs in the
/// selected payment.
/// This state will be used to show the error message.
class SelectedPaymentErrorState extends SelectedPaymentState {
  /// [errorMessage] is the error message.
  final String errorMessage;

  SelectedPaymentErrorState({required this.errorMessage});
}

/// [SelectedPaymentSuccessState] is the state when the selected payment is
/// successful.
/// This state will be used to show the selected payment.
class SelectedPaymentSuccessState extends SelectedPaymentState {
  /// [paymentToken] is the token for the payment.
  final String paymentToken;

  SelectedPaymentSuccessState({required this.paymentToken});
}
