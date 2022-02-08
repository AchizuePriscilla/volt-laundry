import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/order_apis/order_repo.dart';
import 'package:volt/models/api/get_order_history_response.dart';
import 'package:volt/models/api/login_response.dart';
import 'package:volt/models/process_order_model.dart';
import 'package:volt/models/api/process_order_response.dart';

class OrderRepoImpl extends BaseApi implements OrderRepo {
  OrderRepoImpl(String baseApi) : super(baseApi);
  static const String orderHistory = 'order/user';
  static const order = 'order';
  static const driver = 'logistics/';

  @override
  Future<GetOrderHistoryResponse> getOrderHistory() async {
    var response = await get(orderHistory);
    return GetOrderHistoryResponse.fromMap(response);
  }

  @override
  Future<ProcessOrderResponse> processOrder(ProcessOrderModel request) async {
    var response = await post(order, data: request.toMap());
    return ProcessOrderResponse.fromMap(response);
  }

  @override
  Future<LoginResponse> getDriverDetails(String id) async {
    var response = await get(driver + id);
    return LoginResponse.fromMap(response);
  }
}
