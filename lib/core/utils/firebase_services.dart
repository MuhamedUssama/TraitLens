import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trait_lens/features/auth/data/models/user_model.dart';

class FireBaseService {
  static CollectionReference<UserModel> getUsersCollection() {
    CollectionReference<UserModel> usersCollection = FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (documentSnapshot, options) =>
              UserModel.fromJson(documentSnapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
    return usersCollection;
  }
}
