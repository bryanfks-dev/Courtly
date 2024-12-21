import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/user.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/domain/usecases/verify_password_usecase.dart';
import 'package:courtly/presentation/blocs/states/change_password_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBloc extends Cubit<ChangePasswordState> {
  /// [verifyPasswordUsecase] is the usecase to verify the password.
  final VerifyPasswordUsecase verifyPasswordUsecase;

  /// [userUsecase] is the usecase to manage the user.
  final UserUsecase userUsecase;

  ChangePasswordBloc(
      {required this.verifyPasswordUsecase, required this.userUsecase})
      : super(ChangePasswordInitialState());

  /// [verifyPassword] is a method to verify the password.
  ///
  /// Parameters:
  ///   - [password] is the password to verify.
  ///
  /// Returns a [Future] of [void]
  Future<void> verifyPassword({required String password}) async {
    emit(ChangePasswordVerifyingState());

    // Verify the password.
    final Either<Failure, User> res =
        await verifyPasswordUsecase.verifyPassword(password: password);

    res.fold(
        (l) => emit(ChangePasswordErrorState(errorMessage: l.errorMessage)),
        (r) => emit(ChangePasswordVerifiedState()));
  }

  /// [changePassword] is a method to change the password.
  ///
  /// Parameters:
  ///   - [oldPassword] is the old password.
  ///   - [newPassword] is the new password.
  ///   - [confirmPassword] is the confirm password.
  ///
  /// Returns a [Future] of [void]
  Future<void> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    emit(ChangePasswordChangingState());

    // Change the password.
    final Failure? failure = await userUsecase.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);

    if (failure != null) {
      emit(ChangePasswordErrorState(errorMessage: failure.errorMessage));

      return;
    }

    emit(ChangePasswordSuccessState());
  }
}
