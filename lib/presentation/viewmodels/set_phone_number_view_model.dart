import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class SetPhoneNumberVM extends BaseViewModel {
  void navigateToPhoneNumberVerification() {
    navigationHandler.pushNamed(verificationViewRoute);
  }
}
