import 'package:volt/data/remote/order_apis/order_repo.dart';
import 'package:volt/data/remote/order_apis/order_service.dart';
import 'package:volt/models/api/get_order_history_response.dart';

class OrderServiceImpl extends OrderService {
  final OrderRepo orderRepo;

  OrderServiceImpl({required this.orderRepo});

  @override
  Future<GetOrderHistoryResponse> getOrderHistory() async {
    var res = await orderRepo.getOrderHistory();
    return res;
  }
}
