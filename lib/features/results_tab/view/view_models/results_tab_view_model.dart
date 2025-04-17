import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/features/results_tab/domain/usecases/get_user_detection_results_usecace.dart';
import 'package:trait_lens/features/results_tab/view/view_models/results_tab_states.dart';

@injectable
class ResultsTabViewModel extends Cubit<ResultsTabStates> {
  final GetUserDetectionResultsUsecace _usecace;

  ResultsTabViewModel(this._usecace) : super(ResultTabsInitialState());

  Future<void> getUserDetectionResults() async {
    emit(ResultTabsLoadingState());

    final result = await _usecace.call();

    result.fold(
      (error) {
        emit(ResultTabsErrorState(error.message ?? 'Something went wrong'));
      },
      (results) {
        if (results.isEmpty) {
          emit(ResultTabsEmptyListState());
        } else {
          emit(ResultTabsLoadedState(results));
        }
      },
    );
  }
}
