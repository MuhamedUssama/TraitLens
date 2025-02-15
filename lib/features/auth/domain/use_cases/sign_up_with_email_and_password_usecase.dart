import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

import '../repository/auth_repository.dart';

@injectable
class SignUpWithEmailAndPasswordUsecase {
  final AuthRepository _authRepository;

  @factoryMethod
  SignUpWithEmailAndPasswordUsecase(this._authRepository);

  Future<Either<ServerException, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
