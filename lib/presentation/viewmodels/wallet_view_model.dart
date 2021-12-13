import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class WalletVM extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  void showDialog(DialogContentType contentType) {
    dialogHandler.showDialog(
        dismissable: true, contentType: contentType, message: 'Order Placed');
  }
}
