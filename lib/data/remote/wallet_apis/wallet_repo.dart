import 'package:volt/models/api/get_wallet_history_response.dart';
import 'package:volt/models/api/transaction_init_response.dart';
import 'package:volt/models/api/transaction_reqests.dart';

abstract class WalletRepo {
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request);

  Future<GetWalletHistoryResponse> getWalletHistory();
}
