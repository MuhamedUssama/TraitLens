import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/firebase_services.dart';
import '../../../fill_profile/data/models/fill_profile_model.dart';
import '../../../fill_profile/domain/entities/fill_profile_entity.dart';
import '../data_source/profile_tab_data_source.dart';

@Injectable(as: ProfileTabDataSource)
class ProfileTabDataSourceImpl implements ProfileTabDataSource {
  @override
  Future<Either<ServerException, UserProfileEntity>> getUserData({
    required String userId,
  }) async {
    try {
      DocumentSnapshot<UserProfileModel> docSnapshot =
          await FireBaseService.getUserProfileCollection(userId)
              .doc(userId)
              .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        UserProfileEntity userProfileEntity = docSnapshot.data()!.toEntity();
        return Right(userProfileEntity);
      } else {
        return const Left(ServerException('User profile not found'));
      }
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}
