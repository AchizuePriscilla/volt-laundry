import 'package:flutter/material.dart';
import 'package:volt/data/local/local_cache.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/utils/locator.dart';

///Base view model with shared dependencies injected.
///All view models must extends this class.
class BaseViewModel extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late DialogHandler dialogHandler;
  late LocalCache localCache;

  BaseViewModel(
      {NavigationHandler? navigationHandler,
      DialogHandler? dialogHandler,
      LocalCache? localCache}) {
    this.navigationHandler = navigationHandler ?? locator();
    this.dialogHandler = dialogHandler ?? locator();
    this.localCache = localCache ?? locator();
  }


  bool _loading = false;
  bool get loading => _loading;

  void toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}
