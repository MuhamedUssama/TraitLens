import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trait_lens/features/on_boarding/view_model/on_boarding_states.dart';

class OnBoardingViewModel extends Cubit<OnBoardingStates> {
  OnBoardingViewModel() : super(OnBoardingInitialState()) {
    _pageController = PageController(initialPage: 0);
  }

  int _currentPage = 0;
  late PageController _pageController;

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;

  void setCurrentIndex(int index) {
    _currentPage = index;
    emit(OnBoardingCurrentIndexState());
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
