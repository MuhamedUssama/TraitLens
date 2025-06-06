import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/auth/data/models/user_model.dart';
import 'package:trait_lens/features/notifications/data/models/notification_model.dart';

import '../../features/fill_profile/data/models/fill_profile_model.dart';

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

  static CollectionReference<UserProfileModel> getUserProfileCollection(
      String userId) {
    CollectionReference<UserProfileModel> userProfileCollection =
        getUsersCollection()
            .doc(userId)
            .collection(UserProfileModel.collectionName)
            .withConverter<UserProfileModel>(
              fromFirestore: (documentSnapshot, options) =>
                  UserProfileModel.fromJson(documentSnapshot.data()!),
              toFirestore: (userProfile, options) => userProfile.toJson(),
            );
    return userProfileCollection;
  }

  static CollectionReference<NotificationModel> getNotificationsCollection() {
    return FirebaseFirestore.instance
        .collection(NotificationModel.collectionName)
        .withConverter<NotificationModel>(
          fromFirestore: (doc, _) => NotificationModel.fromJson(doc.data()!),
          toFirestore: (notif, _) => notif.toJson(),
        );
  }

  static CollectionReference<DetectionResultModel> getUserReslutsCollection(
      String userId) {
    CollectionReference<DetectionResultModel> userProfileCollection =
        getUsersCollection()
            .doc(userId)
            .collection('detectionResults')
            .withConverter<DetectionResultModel>(
              fromFirestore: (documentSnapshot, options) =>
                  DetectionResultModel.fromJson(documentSnapshot.data()!),
              toFirestore: (detectionModel, options) => detectionModel.toJson(),
            );
    return userProfileCollection;
  }
}
