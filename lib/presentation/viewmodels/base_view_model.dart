import 'package:flutter/material.dart';
import 'package:volt/data/local/local_cache.dart';
import 'package:volt/data/remote/auth_apis/auth_service.dart';
import 'package:volt/services/services.dart';
import 'package:volt/data/remote/order_apis/order_service.dart';
import 'package:volt/data/remote/wallet_apis/wallet_service.dart';
import 'package:volt/handlers/handlers.dart';
import 'package:volt/utils/locator.dart';

///Base view model with shared dependencies injected.
///All view models must extends this class.
class BaseViewModel extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late DialogHandler dialogHandler;
  late LocalCache localCache;
  late AuthService authService;
  late WalletService walletService;
  late OrderService orderService;
  late GeolocatorService geolocatorService;
  late ImagePickerService imagePickerService;
  late FileDownloadService fileDownloadService;

  BaseViewModel(
      {NavigationHandler? navigationHandler,
      DialogHandler? dialogHandler,
      LocalCache? localCache,
      AuthService? authService,
      WalletService? walletService,
      OrderService? orderService,
      GeolocatorService? geolocatorService,
      ImagePickerService? imagePickerService,
      FileDownloadService? fileDownloadService}) {
    this.navigationHandler = navigationHandler ?? locator();
    this.dialogHandler = dialogHandler ?? locator();
    this.localCache = localCache ?? locator();
    this.authService = authService ?? locator();
    this.walletService = walletService ?? locator();
    this.orderService = orderService ?? locator();
    this.geolocatorService = geolocatorService ?? locator();
    this.imagePickerService = imagePickerService ?? locator();
    this.fileDownloadService = fileDownloadService ?? locator();
  }

  bool _loading = false;
  bool get loading => _loading;

  void toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}
