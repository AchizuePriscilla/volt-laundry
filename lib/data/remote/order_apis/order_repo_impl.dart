import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/order_apis/order_repo.dart';
import 'package:volt/models/api/get_order_history_response.dart';

class OrderRepoImpl extends BaseApi implements OrderRepo {
  OrderRepoImpl(String baseApi) : super(baseApi);
  static const String orderHistory = 'order/user';

  @override
  Future<GetOrderHistoryResponse> getOrderHistory() async {
    var response = await get(orderHistory);
    return GetOrderHistoryResponse.fromMap(response);
  }
}
