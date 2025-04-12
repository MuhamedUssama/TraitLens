import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/core/helpers/connectivity_helper.dart';
import 'package:trait_lens/features/notifications/data/data_source/notifications_data_source.dart';
import 'package:trait_lens/features/notifications/domain/entities/notification_entity.dart';
import 'package:trait_lens/features/notifications/domain/repository/notification_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationsRepositoryImpl implements NotificationRepository {
  final NotificationsDataSource _notificationsDataSource;

  @factoryMethod
  NotificationsRepositoryImpl(this._notificationsDataSource);

  @override
  Future<Either<ServerException, List<NotificationEntity>>>
      getNotifications() async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _notificationsDataSource.getNotifications();

      return either.fold(
        (error) => Left(ServerException(error.message)),
        (response) => Right(response),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }
}
