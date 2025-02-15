import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class SignInWithEmailAndPasswordUsecase {
  final AuthRepository _authRepository;

  @factoryMethod
  SignInWithEmailAndPasswordUsecase(this._authRepository);

  Future<Either<ServerException, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
