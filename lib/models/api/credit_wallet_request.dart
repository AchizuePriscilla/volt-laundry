import 'package:equatable/equatable.dart';

class CreditWalletRequest extends Equatable {
  final double amount;
  final String paymentSource;
  final String? transactionResponse;

  const CreditWalletRequest(
      {required this.amount,
      required this.paymentSource,
      this.transactionResponse = ''});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'paymentSource': paymentSource,
      'transactionResponse': {'response': transactionResponse}
    };
  }

  @override
  List<Object?> get props => [amount, paymentSource, transactionResponse];
}
