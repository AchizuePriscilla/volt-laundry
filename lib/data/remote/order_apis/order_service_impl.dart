import 'package:volt/data/remote/order_apis/order_repo.dart';
import 'package:volt/data/remote/order_apis/order_service.dart';
import 'package:volt/models/api/get_cart_response.dart';
import 'package:volt/models/api/general_response.dart';
import 'package:volt/models/api/get_order_history_response.dart';
import 'package:volt/models/api/get_user_response.dart';
import 'package:volt/models/process_order_model.dart';
import 'package:volt/models/api/process_order_response.dart';

class OrderServiceImpl extends OrderService {
  final OrderRepo orderRepo;

  OrderServiceImpl({required this.orderRepo});

  @override
  Future<GetOrderHistoryResponse> getOrderHistory() async {
    var res = await orderRepo.getOrderHistory();
    return res;
  }

  @override
  Future<ProcessOrderResponse> processOrder(ProcessOrderModel request) async {
    var res = await orderRepo.processOrder(request);
    return res;
  }

  @override
  Future<GetUserResponse> getDriverDetails(String id) async {
    var res = await orderRepo.getDriverDetails(id);
    return res;
  }

  @override
  Future<GeneralResponse> addToCart(UserWear request) async {
    var res = await orderRepo.addToCart(request);
    return res;
  }

  @override
  Future<GetCartResponse> getUserCart() async {
    var res = await orderRepo.getUserCart();
    return res;
  }

  @override
  Future<GeneralResponse> deleteFromCart(UserWear request) async {
    var res = await orderRepo.deleteFromCart(request);
    return res;
  }

  @override
  Future<GeneralResponse> clearCart() async {
    var res = await orderRepo.clearCart();
    return res;
  }
}
