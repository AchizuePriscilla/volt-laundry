import 'package:volt/models/dialog/dialog_request.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class WalletVM extends BaseViewModel {
  void navigateToFundWalletView() {
    navigationHandler.pushNamed(fundWalletViewRoute);
  }

  void showDialog(DialogContentType contentType){
    dialogHandler.showDialog(
        contentType: contentType, message: 'Order Placed');
  }
}
