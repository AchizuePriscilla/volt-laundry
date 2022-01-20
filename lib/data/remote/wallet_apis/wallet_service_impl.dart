import 'package:volt/data/local/local_cache.dart';
import 'package:volt/data/remote/wallet_apis/wallet_repo.dart';
import 'package:volt/data/remote/wallet_apis/wallet_service.dart';
import 'package:volt/models/api/general_response.dart';
import 'package:volt/models/api/credit_wallet_request.dart';
import 'package:volt/models/api/get_wallet_history_response.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/api/transaction_init_response.dart';

class WalletServiceImpl implements WalletService {
  final WalletRepo walletRepo;
  final LocalCache localCache;
  WalletServiceImpl({required this.walletRepo, required this.localCache});
  @override
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request) async {
    var res = await walletRepo.transactionInit(request);
    return res;
  }

  @override
  Future<GetWalletHistoryResponse> getWalletHistory() async {
    var res = await walletRepo.getWalletHistory();
    return res;
  }

  @override
  Future<GeneralResponse> creditWallet(CreditWalletRequest request) async {
    var res = await walletRepo.creditWallet(request);
    return res;
  }
}
