import 'dart:developer';
import 'package:volt/presentation/viewmodels/base_view_model.dart';
import 'package:volt/utils/utils.dart';

import '../../models/api/transaction_reqests.dart';
import '../../models/navigation/confirm_deduct_args.dart';
import '../../models/process_order_model.dart';

class CartVM extends BaseViewModel {
  late PaymentRef _paymentRef;
  late CartModel _cartModel;
  DeliveryMethod _deliveryMethod = DeliveryMethod.pickup;
  void setDeliveryMethod(DeliveryMethod deliveryMethod) {
    _deliveryMethod = deliveryMethod;
    _paymentRef = PaymentRef.fromMap({'json': ''});
  }

  int get totalUserWears => _cartModel.cart
      .fold(0, (previousValue, element) => previousValue + element.wearTotal);

  int get totalPrice => _cartModel.cart.fold(
      0, (previousValue, element) => previousValue + element.price.amount);

  void navigateToRoute(String route, dynamic args) {
    navigationHandler.pushNamed(route, arg: args);
  }

  ClothType getClothTypeEnum(String wearType) {
    switch (wearType) {
      case "T-Shirts":
        return ClothType.tShirt;
      case "Shorts":
        return ClothType.shorts;
      case "Cardigans":
        return ClothType.cardigans;
      case "Dresses":
        return ClothType.dresses;
      case "Home":
        return ClothType.home;
      case "Others":
        return ClothType.others;

      default:
        return ClothType.others;
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

  Future<void> addToCart(
      {required ClothType clothType,
      required List<dynamic> wearColor,
      required int wearTotal,
      required int amount,
      required ServiceType serviceType,
      required String description}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.addToCart(
        UserWear(
          wearType: getDesc(clothType),
          description: description,
          wearColor: wearColor,
          wearTotal: wearTotal,
          price: DeliveryFee(currency: 'VLTCOIN', amount: amount),
          serviceType: getServiceType(serviceType),
        ),
      );
      if (res.success) {
        navigationHandler.popAndPushNamed(cartViewRoute);
      } else {
        dialogHandler.showDialog(
            contentType: DialogContentType.error,
            message: res.error!.message,
            autoDismiss: true,
            title: "Error");
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<List<UserWear>> getUserCart() async {
    try {
      var res = await orderService.getUserCart();
      _cartModel = res.cartModel!;
      return _cartModel.cart;
    } catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }

  Future<void> clearCart() async {
    try {
      await orderService.clearCart();
      notifyListeners();
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  Future<void> deleteFromCart(UserWear userWear) async {
    try {
      toggleLoading(true);
      await orderService.deleteFromCart(userWear);
      notifyListeners();
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> transactionInit({
    required String email,
    required double amount,
    required int deliveryFee,
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
          arg: ConfirmDeductArgs(
              amount: amount,
              deliveryFee: deliveryFee,
              isCartOrder: true,
              isSingleCartOrder: false),
        );
      } else {
        //show error messagge
        log('message: ${res.error!.message.toString()}');
        dialogHandler.showDialog(
            contentType: DialogContentType.error,
            message: res.error!.message,
            autoDismiss: true,
            title: "Error");
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }


  Future<void> singleTransactionInit(
      {required String email,
      required double amount,
      required int deliveryFee,
      required UserWear userWear}) async {
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
          arg: ConfirmDeductArgs(
              amount: amount,
              deliveryFee: deliveryFee,
              isCartOrder: true,
              isSingleCartOrder: true,
              userWear: userWear),
        );
      } else {
        //show error messagge
        log('message: ${res.error!.message.toString()}');
        dialogHandler.showDialog(
            contentType: DialogContentType.error,
            message: res.error!.message,
            autoDismiss: true,
            title: "Error");
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> processSingleOrder({
    required int deliveryFee,
    required UserWear userWear,
  }) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.processOrder(
        ProcessOrderModel(
            deliveryMode: _deliveryMethod.name.toUpperCase(),
            userWears: _cartModel.cart,
            price:
                DeliveryFee(amount: userWear.price.amount, currency: 'VLTCOIN'),
            deliveryFee: DeliveryFee(amount: deliveryFee, currency: 'VLTCOIN'),
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
        await deleteFromCart(userWear);
        await getUserCart();
        notifyListeners();
        dialogHandler.showDialog(
            contentType: DialogContentType.success,
            autoDismiss: true,
            title: "Success",
            message: "Order Placed Successfully");
        Future.delayed(const Duration(seconds: 2), () {
          navigationHandler.pushNamed(homeViewRoute);
        });
      } else {
        log(res.error!.message);
        dialogHandler.showDialog(
            contentType: DialogContentType.error,
            message: res.error!.message,
            autoDismiss: false,
            title: "Error");
      }

      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> processOrder(
      {required int deliveryFee, required int totalPrice}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.processOrder(
        ProcessOrderModel(
            deliveryMode: _deliveryMethod.name.toUpperCase(),
            userWears: _cartModel.cart,
            price: DeliveryFee(amount: totalPrice, currency: 'VLTCOIN'),
            deliveryFee: DeliveryFee(amount: deliveryFee, currency: 'VLTCOIN'),
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
        await clearCart();
        await getUserCart();
        notifyListeners();
        dialogHandler.showDialog(
            contentType: DialogContentType.success,
            autoDismiss: true,
            title: "Success",
            message: "Order Placed Successfully");
        Future.delayed(const Duration(seconds: 2), () {
          navigationHandler.pushNamed(homeViewRoute);
        });
      } else {
        log(res.error!.message);
        dialogHandler.showDialog(
            contentType: DialogContentType.error,
            message: res.error!.message,
            autoDismiss: false,
            title: "Error");
      }

      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}
