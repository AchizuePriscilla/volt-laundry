import 'dart:developer';
import 'package:flutter/painting.dart';
import 'package:volt/models/api/transaction_reqests.dart';
import 'package:volt/models/navigation/confirm_deduct_args.dart';
import 'package:volt/models/navigation/laundry_details_args.dart';
import 'package:volt/models/order_history_model.dart' as order_history;
import 'package:volt/models/process_order_model.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/utils.dart';

class LaundryVM extends BaseViewModel {
  late order_history.OrderHistoryModel _orderHistoryModel;
  late ServiceType _serviceType;
  late ClothType _clothType;
  List<int> _colors = <int>[];
  List<UserWear> userWears = <UserWear>[];
  // late int _numberOfClothes;
  DeliveryMethod _deliveryMethod = DeliveryMethod.pickup;
  late PaymentRef _paymentRef;
  late DeliveryFee _deliveryFee;
  void setDeliveryMethod(DeliveryMethod deliveryMethod) {
    _deliveryMethod = deliveryMethod;
    _paymentRef = PaymentRef.fromMap({'json': ''});
  }

  void updateValues(
      {required ClothType clothType,
      required int total,
      required ServiceType serviceType,
      required List<int> colors}) {
    _deliveryFee = DeliveryFee(currency: 'VLTCOIN', amount: 20);
    _colors = colors;
    userWears.add(
      UserWear(
          price: _deliveryFee,
          wearColor: _colors,
          wearType: getDesc(clothType),
          wearTotal: total),
    );
    _serviceType = serviceType;
  }

  String getDesc(ClothType clothType) {
    switch (clothType) {
      case ClothType.tShirt:
        return "T-Shirts";
      case ClothType.shorts:
        return "Shorts";
      case ClothType.cardigans:
        return "Cardigans";
      case ClothType.dresses:
        return "Dresses";
      case ClothType.home:
        return "Home";
      case ClothType.others:
        return "Others";

      default:
        return "Unknown";
    }
  }

  String getServiceDesc(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ironing:
        return "Ironing";
      case ServiceType.dryCleaning:
        return "Dry Cleaning";
      case ServiceType.washAndIron:
        return "Wash & Iron";

      default:
        return "Unknown";
    }
  }

  String getServiceType(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ironing:
        return "IRON";
      case ServiceType.dryCleaning:
        return "DRY_CLEAN";
      case ServiceType.washAndIron:
        return "WASH_IRON";

      default:
        return "Unknown";
    }
  }

 ServiceType getServiceTypeEnum(String serviceType) {
    switch (serviceType) {
      case "IRON":
        return ServiceType.ironing;
      case "DRY_CLEAN":
        return ServiceType.dryCleaning;
      case "WASH_IRON":
        return ServiceType.washAndIron;

      default:
        return ServiceType.washAndIron;
    }
  }

  String getServiceImagePath(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ironing:
        return "assets/images/iron.png";
      case ServiceType.dryCleaning:
        return "assets/images/dry_clean.png";
      case ServiceType.washAndIron:
        return "assets/images/wash_and_iron.png";

      default:
        return "Unknown";
    }
  }

  String getImagePath(ClothType clothType) {
    switch (clothType) {
      case ClothType.tShirt:
        return "shirt";
      case ClothType.shorts:
        return "trousers";
      case ClothType.cardigans:
        return "cardigan";
      case ClothType.dresses:
        return "dress";
      case ClothType.home:
        return "home";
      case ClothType.others:
        return "tie";

      default:
        return "Unknown";
    }
  }

  void navigateToLaundryDetailsView(
      ClothType clothType, ServiceType serviceType) {
    navigationHandler.pushNamed(laundryDetailsRoute,
        arg: LaundryDetailsArgs(clothType, serviceType));
  }

  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  List<order_history.Order> get orderHistory {
    try {
      return _orderHistoryModel.orders;
    } catch (e) {
      return [];
    }
  }

  Future<List<order_history.Order>> getOrderHistory() async {
    try {
      final response = await orderService.getOrderHistory();
      _orderHistoryModel = response.orderHistory!;
      return _orderHistoryModel.orders;
    } catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }

  Future<void> transactionInit({
    required String email,
    required double amount,
  }) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await walletService.transactionInit(
        TransactionInitRequest(email: email, amount: amount),
      );
      if (res.success) {
        _paymentRef = PaymentRef.fromMap({'ref': res.reference});

        log("PaymentRef: ${_paymentRef.toString()}");
        navigationHandler.pushNamed(
          confirmDeductViewRoute,
          arg: ConfirmDeductArgs(amount: amount),
        );
      } else {
        //show error messagge
        log('message: ${res.error!.message.toString()}');
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> processOrder() async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.processOrder(
        ProcessOrderModel(
            serviceType: getServiceType(_serviceType),
            deliveryMode: _deliveryMethod.name.toUpperCase(),
            userWears: userWears,
            price: _deliveryFee,
            deliveryFee: _deliveryFee,
            paymentMethod: 'COIN',
            origin: CurrentLocation(address: 'UNN', lat: 6.8645, lng: 7.4083),
            destination: CurrentLocation(
                address: 'Volt factory', lat: 7.4083, lng: 7.4083),
            currentLocation:
                CurrentLocation(address: 'UNN', lat: 6.8645, lng: 7.4083),
            status: 'PLACED',
            paymentRef: _paymentRef),
      );
      if (res.success) {
        log('Order Id: ${res.orderId}');
      } else {
        log(res.error!.message);
      }

      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}
