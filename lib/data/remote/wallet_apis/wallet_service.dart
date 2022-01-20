import 'package:volt/models/api/api.dart';
import 'package:volt/models/api/credit_wallet_request.dart';
import 'package:volt/models/api/get_wallet_history_response.dart';
import 'package:volt/models/api/transaction_init_response.dart';
import 'package:volt/models/api/transaction_reqests.dart';

abstract class WalletService {
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request);

  Future<GetWalletHistoryResponse> getWalletHistory();

  Future<GeneralResponse> creditWallet(
    CreditWalletRequest request
  );
}
