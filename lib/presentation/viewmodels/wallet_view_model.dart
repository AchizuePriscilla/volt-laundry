import 'dart:developer';

import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class WalletVM extends BaseViewModel {
  late String accessCode;
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  void popContext() {
    navigationHandler.goBack();
  }

  void showDialog(DialogContentType contentType,
      {String? message, bool autoDismiss = true}) {
    dialogHandler.showDialog(
        dismissable: true,
        contentType: contentType,
        message: message ?? 'Order Placed',
        autoDismiss: autoDismiss);
  }

  ///validates card Number text field
  String? validateCardNumber(String cardNumber) =>
      Validators.validateCardNumber(cardNumber);

  ///Validates expiry month text field
  String? validateExpiryMonth(String expiryMonth) =>
      Validators.validateExpiryMonth(expiryMonth);

  ///Validates expiry year text field
  String? validateExpiryYear(String expiryYear) =>
      Validators.validateExpiryYear(expiryYear);

  ///Validates CVV text field
  String? validateCVV(String cvv) => Validators.validateCVV(cvv);

  ///Validates amount text field
  String? validateAmount(String amount) =>
      Validators.validateTextInput(amount, 'amount');

  ///Validates full name text field
  String? validateFullName(String name) => Validators.validateFullName(name);

  Future<void> transactionInit({
    required String email,
    required double amount,
  }) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await transactionService.transactionInit(
        TransactionInitRequest(email: email, amount: amount),
      );
      if (res.success) {
        accessCode = res.accessCode;
        log(accessCode);
      } else {
        //show error messagge
        log('message: ${res.error!.message.toString()}');
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}
