import 'package:courtly/core/errors/failure.dart';
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
}
