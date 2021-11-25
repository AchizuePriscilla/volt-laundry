import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class WalletVM extends BaseViewModel {
  void navigateToFundWalletView() {
    navigationHandler.pushNamed(fundWalletViewRoute);
  }

  void showDialog() {
    dialogHandler.showDialog(
        contentType: DialogContentType.success, message: 'Order Placed');
  }
}
