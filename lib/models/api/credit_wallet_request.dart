import 'package:equatable/equatable.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CreditWalletRequest extends Equatable {
  final double amount;
  final String paymentSource;
  final CheckoutResponse? transactionResponse;

  const CreditWalletRequest(
      {required this.amount,
      required this.paymentSource,
      this.transactionResponse});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'paymentSource': paymentSource,
      'transactionResponse': {"response": transactionResponse}
    };
  }

  @override
  List<Object?> get props => [amount, paymentSource, transactionResponse];
}
