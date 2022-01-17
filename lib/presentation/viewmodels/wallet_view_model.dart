import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:volt/data/local/local.dart';
import 'package:volt/models/api/general_request.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/wallet_history_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class WalletVM extends BaseViewModel {
  late String accessCode;
  late WalletHistoryModel _walletHistory;

  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

 List<History> get walletHistory {
    try {
      return _walletHistory.history;
    } catch (e) {
      return [];
    }
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
  String getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  Future<void> getWalletHistory() async {
    final response = await walletService.getWalletHistory();
    _walletHistory = response.walletHistory!;
  }

  _chargeCard(
      {required String accessCode,
      required BuildContext context,
      // required PaymentCard getCardFromUI,
      required int amount,
      required PaystackPlugin paystackPlugin,
      required String email}) async {
    var charge = Charge()
      ..accessCode = accessCode
      ..amount = amount
      ..reference = getReference()
      // ..card = getCardFromUI
      ..email = email;

    final response = await paystackPlugin.checkout(context,
        charge: charge, method: CheckoutMethod.card);

    log(response.status.toString());
    AppLogger.logger.d(response.message);
    // Use the response
  }

  Future<void> transactionInit(
      {required String email,
      required double amount,
      required BuildContext context,
      // required PaymentCard getCardFromUI,
      required PaystackPlugin paystackPlugin}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await walletService.transactionInit(
        TransactionInitRequest(email: email, amount: amount),
      );
      if (res.success) {
        accessCode = res.accessCode;

        log(accessCode);
        _chargeCard(
            accessCode: accessCode,
            context: context,
            // getCardFromUI: getCardFromUI,
            amount: amount.toInt(),
            paystackPlugin: paystackPlugin,
            email: email);
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
