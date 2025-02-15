import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:trait_lens/core/errors/exceptions.dart';

import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  @factoryMethod
  AuthRepositoryImpl(this._authDataSource);

  Future<bool> _checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }

  @override
  Future<Either<ServerException, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final either = await _authDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (await _checkInternetConnection()) {
      return either.fold(
        (error) => left(ServerException(error.toString())),
        (user) => right(user),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, String>> verifyAccount() async {
    final either = await _authDataSource.verifyAccount();

    if (await _checkInternetConnection()) {
      return either.fold(
        (error) => left(ServerException(error.toString())),
        (message) => right(message),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final either = await _authDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (await _checkInternetConnection()) {
      return either.fold(
        (error) => left(ServerException(error.toString())),
        (user) => right(user),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithFacebook() async {
    final either = await _authDataSource.signInWithFacebook();

    if (await _checkInternetConnection()) {
      return either.fold(
        (error) => left(ServerException(error.toString())),
        (user) => right(user),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithGoogle() async {
    final either = await _authDataSource.signInWithGoogle();

    if (await _checkInternetConnection()) {
      return either.fold(
        (error) => left(ServerException(error.toString())),
        (user) => right(user),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }
}
