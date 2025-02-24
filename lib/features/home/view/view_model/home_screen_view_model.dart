import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../home_tab/view/ui/home_tab.dart';
import '../../../profile_tab/view/ui/profile_tab.dart';
import '../../../results_tab/view/ui/results_tab.dart';
import 'home_screen_states.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  @factoryMethod
  HomeScreenViewModel() : super(HomeTabState());

  int currentIndex = 0;

  List<Widget> tabs = [
    const HomeTab(),
    const ResultsTab(),
    ProfileTab(),
  ];

  void onTabClicked(int tabIndex) {
    if (currentIndex != tabIndex) {
      currentIndex = tabIndex;
      if (tabIndex == 0) {
        emit(HomeTabState());
      } else if (tabIndex == 1) {
        emit(ResultsTabState());
      } else if (tabIndex == 2) {
        emit(ProfileTabState());
      }
    }
  }
}
