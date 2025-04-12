import 'package:dartz/dartz.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';

abstract interface class NotificationsDataSource {
  Future<Either<ServerException, List<NotificationEntity>>> getNotifications();
}
