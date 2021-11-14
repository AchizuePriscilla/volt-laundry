import 'dart:async';
import 'dart:developer';

import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class VerificationViewModel extends BaseViewModel {
  static const int MINUTES = 5;
  int _minutes = MINUTES;
  int _seconds = 0;

  ///Returns formatted time string
  String get getTime =>
      '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}';

  ///Returns [true] if countdown is active, otherwise [false]
  bool get active => _minutes < MINUTES;

  ///Resets timer to 0[MINUTES]: 00 (e.g 05 : 00 if MINUTES is 5)
  void resetTimer() {
    _seconds = 0;
    _minutes = MINUTES;
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
  void navigateToSignUp() {
    navigationHandler.pushNamed(signUpViewRoute);
  }
}
