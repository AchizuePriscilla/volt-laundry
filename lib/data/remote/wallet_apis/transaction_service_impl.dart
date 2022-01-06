import 'package:volt/data/remote/wallet_apis/transaction_repo.dart';
import 'package:volt/data/remote/wallet_apis/transaction_service.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/api/transaction_init_response.dart';

class TransactionServiceImpl implements TransactionService {
  final TransactionRepo transactionRepo;

  TransactionServiceImpl({required this.transactionRepo});
  @override
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request) async {
    var res = await transactionRepo.transactionInit(request);
    return res;
  }
}
