import 'package:volt/models/api/get_order_history_response.dart';

abstract class OrderService {
  Future<GetOrderHistoryResponse> getOrderHistory();
}
