import 'package:volt/presentation/viewmodels/viewmodels.dart';

class DrawerVM extends BaseViewModel {
  ///Navigates to `route`
  Future<void> navigateToRoute(String route, {bool signOut = false}) async {
    //TODO: implement signout
    // if (signOut) {}
    navigationHandler.pushNamed(route);
  }
}
