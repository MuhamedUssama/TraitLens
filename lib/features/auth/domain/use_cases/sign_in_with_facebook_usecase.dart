import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class SignInWithFacebookUsecase {
  final AuthRepository _authRepository;

  @factoryMethod
  SignInWithFacebookUsecase(this._authRepository);

  Future<Either<ServerException, UserEntity>> call() async {
    return await _authRepository.signInWithFacebook();
  }
}
