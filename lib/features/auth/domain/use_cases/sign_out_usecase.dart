import 'package:injectable/injectable.dart';

import '../repository/auth_repository.dart';

@injectable
class SignOutUsecase {
  final AuthRepository _authRepository;

  @factoryMethod
  SignOutUsecase(this._authRepository);

  Future<void> call() async {
    return await _authRepository.signOut();
  }
}
