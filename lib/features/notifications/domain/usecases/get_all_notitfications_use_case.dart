import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';
import 'package:trait_lens/features/notifications/domain/repository/notification_repository.dart';

@injectable
class GetAllNotitficationsUseCase {
  final NotificationRepository _repository;

  const GetAllNotitficationsUseCase(this._repository);

  Future<Either<ServerException, List<NotificationEntity>>> call() async =>
      _repository.getNotifications();
}
