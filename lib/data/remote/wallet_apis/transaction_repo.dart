import 'package:volt/models/api/transaction_init_response.dart';
import 'package:volt/models/api/transaction_reqests.dart';
abstract class TransactionRepo{
  Future<TransactionInitResponse> transactionInit(
    TransactionInitRequest request
  );
  }