import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class LogInViewModel extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

}
