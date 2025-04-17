import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';

sealed class ResultsTabStates {}

class ResultTabsInitialState extends ResultsTabStates {}

class ResultTabsLoadingState extends ResultsTabStates {}

class ResultTabsLoadedState extends ResultsTabStates {
  final List<DetectionResultModel> results;
  ResultTabsLoadedState(this.results);
}

class ResultTabsErrorState extends ResultsTabStates {
  final String message;
  ResultTabsErrorState(this.message);
}

class ResultTabsEmptyListState extends ResultsTabStates {
  ResultTabsEmptyListState();
}
