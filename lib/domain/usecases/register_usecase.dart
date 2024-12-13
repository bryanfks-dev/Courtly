import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/data/dto/register_form_dto.dart';
import 'package:courtly/data/dto/register_response_dto.dart';
import 'package:courtly/data/repository/api/register_repository.dart';
import 'package:dartz/dartz.dart';

/// [RegisterUsecase] is a class to handle register usecase.
class RegisterUsecase {
  /// [registerRepository] is the register repository.
  final RegisterRepository registerRepository;

  RegisterUsecase({required this.registerRepository});

  /// [register] is a function to handle the register usecase.
  /// 
  /// Parameters:
  ///   - [formDto] is the register form data.
  /// 
  /// Returns a [Failure] object.
  Future<Failure?> register({required RegisterFormDTO formDto}) async {
    // Make a POST request to the API.
    final Either<Failure, RegisterResponseDTO> res =
        await registerRepository.postRegister(formDto: formDto);

    return res.fold((l) => l, (r) => null);
  }
}
