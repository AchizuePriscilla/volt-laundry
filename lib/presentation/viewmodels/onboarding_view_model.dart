// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class OnboardingVM extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
 set currentIndex(int index) => _currentIndex = index;

  late PageController _pageController;
  PageController get pageController => _pageController;

  ///Handles navigation when `Next` or `Skip` buttons are tapped
  Future<void> changePage(int index, [bool tapped = false]) async {
    _currentIndex = index;
    //if current page is last page, exit onboarding view
    if (_currentIndex == 3 && tapped) {
      await navigateToSetPhoneNumber();
      return;
    }
    //else, animate to next onboarding page
    // _currentIndex != 2 ? _currentIndex++ : _currentIndex = 0;

    pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  ///Initializes [_pageController] and starts animation
  void initState(PageController controller) {
    _pageController = controller;
  }

  ///Navigates to SignUpPagesView and cache onboarding status
  Future<void> navigateToSetPhoneNumber() async {
    // TODO: cache navigation status
    // await localCache.saveToLocalCache(key: ONBOARDING_DONE, value: true);
    navigationHandler.pushReplacementNamed(setPhoneNumberViewRoute);
  }
}
