import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/fill_profile/domain/entities/fill_profile_entity.dart';

import '../../domain/repository/fill_profile_repository.dart';
import '../data_source/fill_profile_data_source.dart';

@Injectable(as: FillProfileRepository)
class FillProfileRepositoryImpl implements FillProfileRepository {
  final FillProfileDataSource _fillProfileDataSource;

  @factoryMethod
  FillProfileRepositoryImpl(this._fillProfileDataSource);

  Future<bool> _checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }

  @override
  Future<Either<ServerException, UserProfileEntity>> setProfile({
    required String userId,
    required String fullName,
    required String birthDay,
    required String phone,
    required String gender,
    File? imageFile,
  }) async {
    if (await _checkInternetConnection()) {
      final either = await _fillProfileDataSource.setProfile(
        userId: userId,
        fullName: fullName,
        birthDay: birthDay,
        phone: phone,
        gender: gender,
        imageFile: imageFile,
      );

      return either.fold(
        (error) => left(ServerException(error.toString())),
        (user) => right(user),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }
}
