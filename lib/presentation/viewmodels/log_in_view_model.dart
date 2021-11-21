import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class LogInViewModel extends BaseViewModel {
  void navigateToSignUpView() {
    navigationHandler.pushNamed(signUpViewRoute);
  }

  void navigateToHomeView() {
    navigationHandler.pushNamed(homeViewRoute);
  }

  void navigateToForgotPasswordView() {
    navigationHandler.pushNamed(forgotPasswordViewRoute);
  }

  void navigateToResetPasswordView() {
    navigationHandler.pushNamed(resetPasswordViewRoute);
  }
}
