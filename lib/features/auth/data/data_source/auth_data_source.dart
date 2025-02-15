import 'package:dartz/dartz.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthDataSource {
  Future<Either<ServerException, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<ServerException, UserEntity>> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<ServerException, UserEntity>> signInWithGoogle();

  Future<Either<ServerException, UserEntity>> signInWithFacebook();

  Future<Either<ServerException, String>> verifyAccount();

  Future<void> signOut();
}
