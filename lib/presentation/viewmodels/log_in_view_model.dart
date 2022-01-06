import 'dart:developer';

import 'package:volt/models/api/auth_requests.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LogInViewModel extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  ///validates password text field
  String? validatePassword(String password) =>
      Validators.validatePassword(password);

  ///Makes a network call to log user in with [email] and [password]
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      if (loading) return;
      toggleLoading(true);

      var res = await authService.logIn(LoginRequest(
        email: email,
        password: password,
      ));

      if (res.success) {
        navigationHandler.pushReplacementNamed(homeViewRoute);
        log(res.user!.email);
      } else {
        if (res.error!.type == ErrorType.emailNotValidated) {
          //navigate to AccountVerificationViewRoute
          navigationHandler.pushReplacementNamed(
            verificationViewRoute,
          );
        }
        //show error messagge
        log('message: ${res.error!.message.toString()}');
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}
