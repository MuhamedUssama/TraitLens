import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/auth/data/data_source/auth_data_source.dart';
import 'package:trait_lens/features/auth/data/models/user_model.dart';
import 'package:trait_lens/features/auth/domain/entities/user_entity.dart';

import '../../../../core/utils/firebase_services.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<Either<ServerException, UserEntity>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        return left(const ServerException("User creation failed"));
      }

      UserModel userModel = UserModel(id: credential.user!.uid, email: email);
      CollectionReference<UserModel> usersCollection =
          FireBaseService.getUsersCollection();
      await usersCollection.doc(userModel.id).set(userModel);

      UserEntity userEntity = userModel.toEntity();

      return right(userEntity);
    } on FirebaseAuthException catch (error) {
      return left(ServerException(error.message));
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        return left(const ServerException("User creation failed"));
      }

      CollectionReference<UserModel> usersCollection =
          FireBaseService.getUsersCollection();

      DocumentSnapshot<UserModel> documentSnapShot =
          await usersCollection.doc(credential.user!.uid).get();

      UserModel userModel = documentSnapShot.data()!;
      UserEntity userEntity = userModel.toEntity();

      return right(userEntity);
    } on FirebaseAuthException catch (error) {
      return left(ServerException(error.message));
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status != LoginStatus.success) {
        return left(
            ServerException("Facebook sign-in failed: ${loginResult.message}"));
      }

      final OAuthCredential credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        return left(const ServerException("Facebook authentication failed"));
      }

      final UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
      );

      await FireBaseService.getUsersCollection()
          .doc(userModel.id)
          .set(userModel, SetOptions(merge: true));

      return right(userModel.toEntity());
    } on FirebaseAuthException catch (error) {
      return left(
          ServerException(error.message ?? "Facebook authentication error"));
    } catch (error) {
      return left(ServerException(error.toString()));
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return left(const ServerException("Google sign-in aborted"));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        return left(const ServerException("Google authentication failed"));
      }

      final UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
      );

      await FireBaseService.getUsersCollection()
          .doc(userModel.id)
          .set(userModel);

      return right(userModel.toEntity());
    } on FirebaseAuthException catch (error) {
      return left(
          ServerException(error.message ?? "Google authentication error"));
    } catch (error) {
      return left(ServerException(error.toString()));
    }
  }

  @override
  Future<void> signOut() => FirebaseAuth.instance.signOut();

  @override
  Future<Either<ServerException, void>> verifyAccount() async {
    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return right(null);
    } else {
      return left(const ServerException("Email already verified"));
    }
  }
}
