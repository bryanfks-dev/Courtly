import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/presentation/blocs/states/change_username_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeUsernameBloc extends Cubit<ChangeUsernameState> {
  /// [userUsecase] is the user usecase.
  final UserUsecase userUsecase;

  /// [ChangeUsernameBloc] is a class which is used to manage the state of change username bloc.
  ChangeUsernameBloc({required this.userUsecase})
      : super(ChangeUsernameInitialState());

  /// [changeUsername] is a method which is used to change the username.
  /// This method is used to change the username.
  ///
  /// Parameters:
  ///   - [newUsername] is the new username.
  ///
  /// Returns [void]
  Future<void> changeUsername({required String newUsername}) async {
    emit(ChangeUsernameLoadingState());

    // Perform change username
    final Failure? failure =
        await userUsecase.changeUsername(newUsername: newUsername);

    // Check for failure
    if (failure != null) {
      emit(ChangeUsernameErrorState(
        errorMessage: failure.errorMessage,
      ));

      return;
    }

    emit(ChangeUsernameSuccessState());
  }
}
