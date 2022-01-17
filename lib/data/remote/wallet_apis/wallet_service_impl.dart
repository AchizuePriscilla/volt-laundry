import 'package:volt/data/remote/wallet_apis/wallet_repo.dart';
import 'package:volt/data/remote/wallet_apis/wallet_service.dart';
import 'package:volt/models/api/get_wallet_history_response.dart';
import 'package:volt/models/api/general_request.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/api/transaction_init_response.dart';

class WalletServiceImpl implements WalletService {
  final WalletRepo walletRepo;

  WalletServiceImpl({required this.walletRepo});
  @override
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request) async {
    var res = await walletRepo.transactionInit(request);
    return res;
  }

  @override
  Future<GetWalletHistoryResponse> getWalletHistory(
      GeneralRequest request) async {
    var res = await walletRepo.getWalletHistory(request);
    return res;
  }
}
