import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class WalletVM extends BaseViewModel{
  void navigateToFundWalletView() {
    navigationHandler.pushNamed(fundWalletViewRoute);
  }
}