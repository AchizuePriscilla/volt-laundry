import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/wallet_apis/transaction_repo.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/api/transaction_init_response.dart';

class TransactionRepoImpl extends BaseApi implements TransactionRepo {
  TransactionRepoImpl(String baseApi) : super(baseApi);
  static const String initializeTransaction = 'transaction/init';
  @override
  Future<TransactionInitResponse> transactionInit(
      TransactionInitRequest request) async {
    var response = await post(initializeTransaction, data: request.toMap());
    return TransactionInitResponse.fromMap(response);
  }
}
