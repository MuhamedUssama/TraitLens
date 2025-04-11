import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/core/utils/firebase_services.dart';
import 'package:trait_lens/features/notifications/data/data_source/notifications_data_source.dart';
import 'package:trait_lens/features/notifications/data/models/notification_model.dart';
import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';

@LazySingleton(as: NotificationsDataSource)
class NotificationsRemoteDataSourceImpl implements NotificationsDataSource {
  @override
  Future<Either<ServerException, List<NotificationEntity>>>
      getNotifications() async {
    try {
      final QuerySnapshot<NotificationModel> snapshot =
          await FireBaseService.getNotificationsCollection()
              .orderBy('id', descending: true)
              .get();

      List<NotificationEntity> notifications =
          snapshot.docs.map((doc) => doc.data().toEntity()).toList();

      return Right(notifications);
    } catch (e) {
      log('❌ Get Notifications Error: $e');
      return const Left(ServerException('Failed to fetch notifications'));
    }
  }
}
