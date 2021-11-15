import 'package:flutter/material.dart';
import 'package:volt/presentation/viewmodels/base_view_model.dart';

class BottomNavBarVM extends BaseViewModel {
  ///PageController to handle page transitions within the HomeView's PageView widget.
  late PageController _pageController;

  int _selectedIndex = 0;

  ///Indicates what the current page is.
  int get selectedIndex => _selectedIndex;

  ///Initializes `_pageController`
  void init(PageController controller) {
    _pageController = controller;
  }

  ///Navigates to HomeViewRoute and jumps to `page` within the HomeView's PageView widget.
  void navigateToHomeAndAnimateToPage(int page) {
    _selectedIndex = page;
    navigationHandler.goBack();
    _pageController.jumpToPage(page);
    notifyListeners();
  }

  ///Jumps to `page` within the HomeView's PageView widget.
  void jumpToPage(int page) {
    _selectedIndex = page;
    notifyListeners();
    _pageController.jumpToPage(page);
  }
}