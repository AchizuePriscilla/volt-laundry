import 'package:volt/models/api/get_order_history_response.dart';

abstract class OrderRepo {
  Future<GetOrderHistoryResponse> getOrderHistory();
}
