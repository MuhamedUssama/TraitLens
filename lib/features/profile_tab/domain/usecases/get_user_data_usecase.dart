import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../repository/profile_tab_repository.dart';

@injectable
class GetUserDataUsecase {
  ProfileTabRepository repository;

  @factoryMethod
  GetUserDataUsecase(this.repository);

  Future<Either<ServerException, UserProfileEntity>> call({
    required String userId,
  }) async {
    return repository.getUserData(userId: userId);
  }
}
