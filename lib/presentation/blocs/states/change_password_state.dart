/// [ChangePasswordState] is the abstract class that will be extended by
/// the change password bloc class.
abstract class ChangePasswordState {}

/// [ChangePasswordInitialState] is the initial state of the change password bloc.
/// This state will be emitted when the change password bloc is initialized.
class ChangePasswordInitialState extends ChangePasswordState {}

/// [ChangePasswordVerifyingState] is the verifying state of the change password bloc.
/// This state will be emitted when the change password bloc is verifying.
class ChangePasswordVerifyingState extends ChangePasswordState {}

/// [ChangePasswordVerifiedState] is the verified state of the change password bloc.
/// This state will be emitted when the change password bloc is verified.
class ChangePasswordVerifiedState extends ChangePasswordState {}

/// [ChangePasswordChangingState] is the changing state of the change password bloc.
/// This state will be emitted when the change password bloc is changing.
class ChangePasswordChangingState extends ChangePasswordState {}

/// [ChangePasswordSuccessState] is the success state of the change password bloc.
/// This state will be emitted when the change password bloc is successful.
class ChangePasswordSuccessState extends ChangePasswordState {}

/// [ChangePasswordErrorState] is the error state of the change password bloc.
/// This state will be emitted when the change password bloc is failed.
class ChangePasswordErrorState extends ChangePasswordState {
  /// [errorMessage] is the error message.
  final dynamic errorMessage;

  ChangePasswordErrorState({required this.errorMessage});
}
