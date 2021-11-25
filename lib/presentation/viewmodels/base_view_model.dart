import 'package:flutter/material.dart';
import 'package:volt/handlers/dialog_handler.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/utils/locator.dart';

///Base view model with shared dependencies injected.
///All view models must extends this class.
class BaseViewModel extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late DialogHandler dialogHandler;

  BaseViewModel({
    NavigationHandler? navigationHandler,
    DialogHandler? dialogHandler,
  }) {
    this.navigationHandler = navigationHandler ?? locator();
    this.dialogHandler = dialogHandler ?? locator();
  }
}
