import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class ProfileVM extends BaseViewModel {
  void navigateToEditProfileView() {
    navigationHandler.pushNamed(editProfileViewRoute);
  }
}
