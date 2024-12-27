import 'dart:convert';
import 'dart:io';

import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/change_password_form_dto.dart';
import 'package:courtly/data/dto/change_profile_picture_dto.dart';
import 'package:courtly/data/dto/change_username_form_dto.dart';
import 'package:courtly/data/dto/user_dto.dart';
import 'package:courtly/data/repository/api/user_repository.dart';
import 'package:courtly/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

/// [UserUsecase] is the usecase for user data.
class UserUsecase {
  /// [userRepository] is the repository for user data.
  final UserRepository userRepository;

  UserUsecase({required this.userRepository});

  /// [getCurrentUser] is a function to get the current user data.
  ///
  /// Returns [Future] of [Either] a [Failure] or [User].
  Future<Either<Failure, User>> getCurrentUser() async {
    // Get current user data
    final Either<Failure, UserDTO> res = await userRepository.getCurrentUser();

    return res.fold((l) => left(l), (r) {
      return Right(User.fromDTO(r));
    });
  }

  /// [changeUsername] is a function to change the username.
  ///
  /// Parameters:
  ///   - [newUsername] is a required String.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> changeUsername({required String newUsername}) async {
    // Create change username form dto
    final ChangeUsernameFormDTO formDto =
        ChangeUsernameFormDTO(newUsername: newUsername);

    // Change the username
    final Failure? res = await userRepository.patchUsername(formDto: formDto);

    return res;
  }

  /// [changePassword] is a function to change the password.
  ///
  /// Parameters:
  ///   - [oldPassword] is a required String.
  ///   - [newPassword] is a required String.
  ///   - [confirmPassword] is a required String.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    // Create change password form dto
    final ChangePasswordFormDTO formDto = ChangePasswordFormDTO(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);

    // Change the password
    final Failure? res = await userRepository.patchPassword(formDto: formDto);

    return res;
  }

  /// [changeProfilePicture] is a function to change the profile picture.
  ///
  /// Parameters:
  ///   - [imageFile] is a required File.
  ///
  /// Returns [Future] of [Failure].
  Future<Failure?> changeProfilePicture({required File imageFile}) async {
    // Create a new instance of the ChangeProfilePictureDTO class.
    final ChangeProfilePictureDTO dto = ChangeProfilePictureDTO(
        image: base64Encode(await imageFile.readAsBytes()));

    // Change the profile picture
    final Failure? res = await userRepository.patchProfilePicture(dto: dto);

    return res;
  }
}
