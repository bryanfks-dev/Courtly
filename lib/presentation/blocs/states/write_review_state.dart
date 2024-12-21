/// [WriteReviewState] is the abstract class that contains all the states of the write review bloc.
abstract class WriteReviewState {}

/// [WriteReviewInitialState] is the initial state of the write review bloc.
/// This state is emitted when the bloc is initialized.
class WriteReviewInitialState extends WriteReviewState {}

/// [WriteReviewLoadingState] is the loading state of the write review bloc.
/// This state is emitted when the bloc is loading.
class WriteReviewLoadingState extends WriteReviewState {}

/// [WriteReviewSuccessState] is the success state of the write review bloc.
/// This state is emitted when the write review is successful.
class WriteReviewSuccessState extends WriteReviewState {}

/// [WriteReviewErrorState] is the error state of the write review bloc.
/// This state is emitted when the write review fails.
class WriteReviewErrorState extends WriteReviewState {
  /// [errorMessage] is the error message.
  final dynamic errorMessage;

  WriteReviewErrorState({required this.errorMessage});
}
