import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/features/notifications/domain/usecases/get_all_notitfications_use_case.dart';
import 'package:trait_lens/features/notifications/view/view_model/notifications_screen_states.dart';

@injectable
class NotificationScreenViewModel extends Cubit<NotificationsScreenStates> {
  final GetAllNotitficationsUseCase _allNotitficationsUseCase;

  @factoryMethod
  NotificationScreenViewModel(this._allNotitficationsUseCase)
      : super(NotificationsScreenInitialState()) {
    getAllNotifications();
  }

  Future<void> getAllNotifications() async {
    emit(NotificationsScreenLoadingState());
    final result = await _allNotitficationsUseCase.call();
    result.fold(
      (error) => emit(NotificationsScreenErrorState(error.toString())),
      (notifications) => emit(NotificationsScreenLoadedState(notifications)),
    );
  }
}
