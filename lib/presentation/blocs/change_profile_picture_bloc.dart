import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/presentation/blocs/states/change_profile_picture_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ChangeProfilePictureBloc] is the bloc for changing the profile picture.
/// This bloc will handle the change profile picture state.
class ChangeProfilePictureBloc extends Cubit<ChangeProfilePictureState> {
  /// [userUsecase] is the user usecase.
  final UserUsecase userUsecase;

  ChangeProfilePictureBloc({required this.userUsecase})
      : super(ChangeProfilePictureInitialState());

  /// [changeProfilePicture] is a function to change the profile picture.
  /// 
  /// Parameters:
  ///   - [imageFile] is the image file to be uploaded.
  /// 
  /// Returns [Future] of [void].
  Future<void> changeProfilePicture({required File imageFile}) async {
    emit(ChangeProfilePictureLoadingState());

    // Change the profile picture
    final Failure? res =
        await userUsecase.changeProfilePicture(imageFile: imageFile);

    // Check if the response is not null
    if (res != null) {
      emit(ChangeProfilePictureErrorState(errorMessage: res.errorMessage));

      return;
    }

    emit(ChangeProfilePictureSuccessState());
  }
}
