import 'dart:async';
import 'dart:developer';
import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class VerificationViewModel extends BaseViewModel {
  static const int minutes = 2;
  int _minutes = minutes;
  int _seconds = 0;

  ///Returns formatted time string
  String get getTime =>
      '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}';

  ///Returns [true] if countdown is active, otherwise [false]
  bool get active => _minutes < minutes;

  bool _resendingToken = false;
  bool get isResendingToken => _resendingToken;

  ///Resets timer to 0[MINUTES]: 00 (e.g 05 : 00 if MINUTES is 5)
  void resetTimer() {
    _seconds = 0;
    _minutes = minutes;
    notifyListeners();
  }

  ///Toggles [_resendingToken]
  void _toggleResending(bool val) {
    _resendingToken = val;
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
  String? validatePhoneNumber(String phoneNumber) =>
      Validators.validatePhoneNumber(phoneNumber);

  ///Makes network call to resend verification token
  Future<void> resendToken(String phoneNumber) async {
    try {
      if (!active) {
        _toggleResending(true);
        var res = await authService.phoneVerification(
            PhoneVerificationRequest(phoneNumber: phoneNumber));

        if (res.success) {
          log(res.code);
        } else {
          //show error message

          if (res.error!.type == ErrorType.emailAlreadyValidated) {
            await localCache.removeFromLocalCache(lastPage);
            await localCache.removeFromLocalCache(lastPhoneNumber);
            dialogHandler.showDialog(
              message: res.error!.message + "\nLogin to continue.",
            );
          } else {
            dialogHandler.showDialog(
              message: res.error!.message,
            );
          }
        }
        _toggleResending(false);
        startTimer();
      }
    } catch (e) {
      _toggleResending(false);
    }
  }

  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  void onPop() {
    navigationHandler.popAndPushNamed(signUpViewRoute);
    resetTimer();
  }
}
