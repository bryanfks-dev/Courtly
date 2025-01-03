import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/usecases/register_usecase.dart';
import 'package:courtly/presentation/blocs/states/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [RegisterBloc] is the business logic component for the registration process.
class RegisterBloc extends Cubit<RegisterState> {
  /// [registerUsecase] is the usecase for registering a user.
  final RegisterUsecase registerUsecase;

  RegisterBloc({required this.registerUsecase}) : super(RegisterInitialState());

  /// [register] is the method for registering a user.
  ///
  /// Parameters:
  ///   - [username] is the username of the user.
  ///   - [phoneNumber] is the phone number of the user.
  ///   - [password] is the password of the user.
  ///   - [confirmPassword] is the confirmation password of the user.
  ///
  /// Returns [void]
  Future<void> register(
      {required String username,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) async {
    emit(RegisterLoadingState());

    // Register the user.
    final Failure? fail = await registerUsecase.register(
        username: username,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword);

    // Check if the registration was successful.
    if (fail == null) {
      emit(RegisterSuccessState());

      return;
    }

    emit(RegisterErrorState(errorMessage: fail.errorMessage));
  }
}
