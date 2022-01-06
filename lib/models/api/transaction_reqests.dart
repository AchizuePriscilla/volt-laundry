import 'package:equatable/equatable.dart';

class TransactionInitRequest extends Equatable {
  final String email;
  final double amount;
  final String? currency;

  const TransactionInitRequest(
      {required this.email, required this.amount, this.currency = 'NGN'});

  Map<String, dynamic> toMap() {
    return {'email': email, 'amount': amount, 'currency': currency};
  }

  @override
  List<Object?> get props => [email, amount, currency];
}
