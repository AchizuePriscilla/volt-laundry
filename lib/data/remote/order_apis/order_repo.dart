import 'package:volt/models/api/get_order_history_response.dart';
import 'package:volt/models/api/process_order_response.dart';
import 'package:volt/models/process_order_model.dart';

abstract class OrderRepo {
  Future<GetOrderHistoryResponse> getOrderHistory();
  Future<ProcessOrderResponse> processOrder(ProcessOrderModel request);
}
