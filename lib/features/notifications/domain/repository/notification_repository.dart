import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';

abstract interface class NotificationRepository {
  Future<Either<ServerException, List<NotificationEntity>>> getNotifications();
}
