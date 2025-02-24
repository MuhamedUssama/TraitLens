import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';

abstract interface class ProfileTabDataSource {
  Future<Either<ServerException, UserProfileEntity>> getUserData();
}
