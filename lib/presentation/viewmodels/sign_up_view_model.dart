import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class SignUpViewModel extends BaseViewModel {
  void navigateToLogInView() {
    navigationHandler.pushNamed(logInViewRoute);
  }
}
