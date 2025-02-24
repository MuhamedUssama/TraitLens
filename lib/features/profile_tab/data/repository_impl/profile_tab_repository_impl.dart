import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:trait_lens/core/errors/exceptions.dart';

import 'package:trait_lens/features/fill_profile/domain/entities/fill_profile_entity.dart';

import '../../domain/repository/profile_tab_repository.dart';
import '../data_source/profile_tab_data_source.dart';

@Injectable(as: ProfileTabRepository)
class ProfileTabRepositoryImpl implements ProfileTabRepository {
  ProfileTabDataSource onlineDataSource;

  @factoryMethod
  ProfileTabRepositoryImpl(this.onlineDataSource);

  Future<bool> _checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }

  @override
  Future<Either<ServerException, UserProfileEntity>> getUserData({
    required String userId,
  }) async {
    if (await _checkInternetConnection()) {
      final either = await onlineDataSource.getUserData(userId: userId);

      return either.fold(
        (error) => Left(ServerException(error.message.toString())),
        (user) => Right(user),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }
}
