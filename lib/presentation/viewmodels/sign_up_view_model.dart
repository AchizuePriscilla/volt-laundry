import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class SignUpViewModel extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  ///validates password text field
  String? validatePassword(String password) =>
      Validators.validatePassword(password);

  ///Validates email text field
  String? validateEmail(String email) => Validators.validateEmail(email);

  
  ///Validates full name text field
  String? validateFullName(String name) => Validators.validateFullName(name);

  ///Validates phone number text field
  String? validatePhoneNumber(String phoneNumber) => Validators.validatePhoneNumber(phoneNumber);


}
