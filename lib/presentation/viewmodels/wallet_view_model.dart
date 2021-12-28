import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';

class WalletVM extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  void showDialog(DialogContentType contentType, {String? message, bool autoDismiss = false}) {
    dialogHandler.showDialog(
        dismissable: true, contentType: contentType, message: message ?? 'Order Placed', autoDismiss: autoDismiss);
  }
}
