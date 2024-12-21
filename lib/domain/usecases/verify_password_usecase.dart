import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/user_dto.dart';
import 'package:courtly/data/dto/verify_password_form_dto.dart';
import 'package:courtly/data/repository/api/verify_password_repository.dart';
import 'package:courtly/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

/// [VerifyPasswordUsecase] is a usecase class that is used to verify the password.
class VerifyPasswordUsecase {
  /// [verifyPasswordRepository] is a repository that is used to verify the password.
  final VerifyPasswordRepository verifyPasswordRepository;

  VerifyPasswordUsecase({required this.verifyPasswordRepository});

  /// [verifyPassword] is a method that verifies the user's password.
  ///
  /// Parameters:
  ///   - [password] is a [String] that represents the user's password.
  ///
  /// Returns a [Future] of [Either] a [Failure] or [User].
  Future<Either<Failure, User>> verifyPassword(
      {required String password}) async {
    // Create verify password form DTO
    final VerifyPasswordFormDTO formDto =
        VerifyPasswordFormDTO(password: password);

    // Send the request to the server
    final Either<Failure, UserDTO> res =
        await verifyPasswordRepository.postPassword(formDto: formDto);

    // Return the user
    return res.fold((l) => left(l), (r) => right(User.fromDTO(r)));
  }
}
