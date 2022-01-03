import 'dart:async';
import 'dart:developer';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class VerificationViewModel extends BaseViewModel {
  static const int minutes = 1;
  int _minutes = minutes;
  int _seconds = 30;

  ///Returns formatted time string
  String get getTime =>
      '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}';

  ///Returns [true] if countdown is active, otherwise [false]
  bool get active => _minutes < minutes;

  ///Resets timer to 0[MINUTES]: 00 (e.g 05 : 00 if MINUTES is 5)
  void resetTimer() {
    _seconds = 30;
    _minutes = minutes;
    notifyListeners();
  }

  ///Returns timer object and handles countdown logic
  Timer? _handleTimer() {
    try {
      resetTimer();
      Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds == 0) {
          _seconds = 59;
          _minutes -= 1;
        } else {
          _seconds -= 1;
        }

        notifyListeners();
      });

      return timer;
    } catch (e) {
      log(e.toString());
    }
  }

  ///Starts countdown and stop/reset stop time
  void startTimer() {
    Timer? timer = _handleTimer();
    if (timer != null) {
      Future.delayed(Duration(minutes: _minutes)).then((value) {
        timer.cancel();
        resetTimer();
      });
    }
  }

  ///Validates phone number text field
  String? validatePhoneNumber(String phoneNumber) => Validators.validatePhoneNumber(phoneNumber);

    ///Removes cached data and navigate to appropriate route
  // Future<void> _removeCachedDataAndNavigate([String? route]) async {
  //   //removes cached data
  //   await localCache.removeFromLocalCache(lastPage);
  //   // await localCache.removeFromLocalCache(lastEmail);

  //   //navigates to APP HomePage
  //   navigationHandler.pushReplacementNamed(route ?? homeViewRoute);
  // }


    ///Makes a network call to verify [phoneNumber] with given [token]
  // Future<void> verifyAccount({
  //   required String phoneNumber,
  //   required String token,
  // }) async {
  //   try {
  //     if (loading) return;
  //     toggleLoading(true);
  //     var res = await authService.verifyAccount(VerifyAccountRequest(
  //       email: email,
  //       token: token,
  //     ));

  //     if (res.success) {
  //       _removeCachedDataAndNavigate();
  //     } else {
  //       //show error messagge
  //       dialogHandler.showDialog(
  //         message: res.error!.message,
  //       );
  //     }
  //     toggleLoading(false);
  //   } catch (e) {
  //     AppLogger.logger.d(e);
  //     toggleLoading(false);
  //   }
  // }

//TODO: Handle caching when user visits verification view

  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }
}
