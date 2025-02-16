import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';

import '../repository/auth_repository.dart';

@injectable
class ForgetPasswordUsecase {
  final AuthRepository _repository;

  @factoryMethod
  ForgetPasswordUsecase(this._repository);

  Future<Either<ServerException, String>> call({required String email}) async {
    return await _repository.forgetPassword(email: email);
  }
}
