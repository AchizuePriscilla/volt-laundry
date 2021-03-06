import 'package:volt/models/api/get_order_history_response.dart';
import 'package:volt/models/api/get_user_response.dart';
import 'package:volt/models/api/process_order_response.dart';
import 'package:volt/models/process_order_model.dart';

import '../../../models/api/general_response.dart';
import '../../../models/api/get_cart_response.dart';

abstract class OrderService {
  Future<GetOrderHistoryResponse> getOrderHistory();
  Future<ProcessOrderResponse> processOrder(ProcessOrderModel request);
  Future<GetUserResponse> getDriverDetails(String id);
  Future<GetCartResponse> getUserCart();
  Future<GeneralResponse> addToCart(UserWear request);
  Future<GeneralResponse> deleteFromCart(UserWear request);
  Future<GeneralResponse> clearCart();
}
