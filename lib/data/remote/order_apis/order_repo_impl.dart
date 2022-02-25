import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/order_apis/order_repo.dart';
import 'package:volt/models/api/get_cart_response.dart';
import 'package:volt/models/api/general_response.dart';
import 'package:volt/models/api/get_order_history_response.dart';
import 'package:volt/models/api/get_user_response.dart';
import 'package:volt/models/process_order_model.dart';
import 'package:volt/models/api/process_order_response.dart';

class OrderRepoImpl extends BaseApi implements OrderRepo {
  OrderRepoImpl(String baseApi) : super(baseApi);
  static const String orderHistory = 'order/user';
  static const order = 'order';
  static const driver = 'logistics/';
  static const cart = 'cart';
  static const clear = 'cart/clear';

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
  Future<GetUserResponse> getDriverDetails(String id) async {
    var response = await get(driver + id);
    return GetUserResponse.fromMap(response);
  }

  @override
  Future<GeneralResponse> addToCart(UserWear request) async {
    var response = await post(cart, data: {"item": request.toMap()});

    return GeneralResponse.fromMap(response);
  }

  @override
  Future<GetCartResponse> getUserCart() async {
    var response = await get(cart);
    return GetCartResponse.fromMap(response);
  }

  @override
  Future<GeneralResponse> deleteFromCart(UserWear request) async {
    var response = await delete(cart, data: {"item": request.toMap()});
    return GeneralResponse.fromMap(response);
  }

  @override
  Future<GeneralResponse> clearCart() async {
    var response = await delete(clear);
    return GeneralResponse.fromMap(response);
  }
}
