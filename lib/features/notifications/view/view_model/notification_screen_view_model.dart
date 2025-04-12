import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trait_lens/features/notifications/domain/usecases/get_all_notitfications_use_case.dart';
import 'package:trait_lens/features/notifications/view/view_model/notifications_screen_states.dart';

class NotificationScreenViewModel extends Cubit<NotificationsTabStates> {
  final GetAllNotitficationsUseCase _allNotitficationsUseCase;

  NotificationScreenViewModel(this._allNotitficationsUseCase)
      : super(NotificationsTabInitialState());

  Future<void> getAllNotifications() async {
    emit(NotificationsTabLoadingState());
    final result = await _allNotitficationsUseCase.call();
    result.fold(
      (error) => emit(NotificationsTabErrorState(error.toString())),
      (notifications) => emit(NotificationsTabLoadedState(notifications)),
    );
  }
}
