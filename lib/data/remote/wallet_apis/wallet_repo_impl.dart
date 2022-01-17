import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/wallet_apis/wallet_repo.dart';
import 'package:volt/models/api/get_wallet_history_response.dart';
import 'package:volt/models/api/general_request.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/api/transaction_init_response.dart';

class WalletRepoImpl extends BaseApi implements WalletRepo {
  WalletRepoImpl(String baseApi) : super(baseApi);
  static const String initializeTransaction = 'transaction/init';
  static const String walletHistory = 'wallet/history/user';
  @override
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request) async {
    var response = await post(initializeTransaction, data: request.toMap());
    return TransactionInitResponse.fromMap(response);
  }

  @override
  Future<GetWalletHistoryResponse> getWalletHistory(
      String accessToken ) async {
    var response = await get(walletHistory);
    return GetWalletHistoryResponse.fromMap(response);
  }
}
