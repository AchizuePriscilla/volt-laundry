import 'package:flutter/material.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/presentation/views/laundry_view.dart';
import 'package:volt/utils/constants.dart';

class HomeVM extends BaseViewModel {
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

  void navigateToCartView() {
    navigationHandler.pushNamed(
      cartViewRoute,
    );
  }

  ///Handles onWillPop of HomeView
  Future<bool> onWillPop() {
    navigationHandler.exitApp();
    return Future.value(false);
  }

  void navigateToLaundryView({String? type}) {
    jumpToPage(2);
    if (type == 'WashAndIron') {
      LaundryView.isWashAndIronDropdownVisible = true;
      LaundryView.isIroningDropdownVisible = false;
      LaundryView.isDrycleaningDropdownVisible = false;
    } else if (type == 'Ironing') {
      LaundryView.isIroningDropdownVisible = true;
      LaundryView.isWashAndIronDropdownVisible = false;
      LaundryView.isDrycleaningDropdownVisible = false;
    } else if (type == 'DryCleaning') {
      LaundryView.isDrycleaningDropdownVisible = true;
      LaundryView.isWashAndIronDropdownVisible = false;
      LaundryView.isIroningDropdownVisible = false;
    } else {
      LaundryView.isDrycleaningDropdownVisible = false;
      LaundryView.isWashAndIronDropdownVisible = false;
      LaundryView.isIroningDropdownVisible = false;
    }
  }
}
