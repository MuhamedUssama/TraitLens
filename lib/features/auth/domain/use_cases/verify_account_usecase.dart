import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../repository/auth_repository.dart';

@injectable
class VerifyAccountUsecase {
  final AuthRepository _authRepository;

  @factoryMethod
  VerifyAccountUsecase(this._authRepository);

  Future<Either<ServerException, String>> call() async {
    return await _authRepository.verifyAccount();
  }
}
