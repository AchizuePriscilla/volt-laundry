import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:volt/presentation/viewmodels/base_view_model.dart';
import 'package:volt/utils/utils.dart';

import '../../models/api/transaction_reqests.dart';
import '../../models/navigation/confirm_deduct_args.dart';
import '../../models/process_order_model.dart';
import '../shared/snackbar.dart';

class CartVM extends BaseViewModel {
  List<UserWear> userWears = <UserWear>[];
  late PaymentRef _paymentRef;
  DeliveryMethod _deliveryMethod = DeliveryMethod.pickup;
  void setDeliveryMethod(DeliveryMethod deliveryMethod) {
    _deliveryMethod = deliveryMethod;
    _paymentRef = PaymentRef.fromMap({'json': ''});
  }

  int get totalUserWears => userWears.fold(
      0, (previousValue, element) => previousValue + element.wearTotal);

  int get totalPrice => userWears.fold(
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

  void addToCart(
      {required ClothType clothType,
      required List<dynamic> wearColor,
      required int wearTotal,
      required int amount,
      required ServiceType serviceType}) {
    userWears.add(UserWear(
        wearType: getDesc(clothType),
        wearColor: wearColor,
        wearTotal: wearTotal,
        price: DeliveryFee(currency: 'VLTCOIN', amount: amount),
        serviceType: getServiceType(serviceType)));
  }

  Future<void> transactionInit(
      {required String email,
      required double amount,
      required int deliveryFee,
      required GlobalKey<ScaffoldMessengerState>? scaffoldKey}) async {
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
          arg: ConfirmDeductArgs(amount: amount, deliveryFee: deliveryFee, isCartOrder: true),
        );
      } else {
        //show error messagge
        log('message: ${res.error!.message.toString()}');
        showSnackbar("Error", res.error!.message, Colors.red, scaffoldKey);
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }

  Future<void> processOrder(
      {required int deliveryFee,
      required int totalPrice,
      required GlobalKey<ScaffoldMessengerState>? scaffoldKey}) async {
    try {
      if (loading) return;
      toggleLoading(true);
      var res = await orderService.processOrder(
        ProcessOrderModel(
            deliveryMode: _deliveryMethod.name.toUpperCase(),
            userWears: userWears,
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
        userWears.clear();
        dialogHandler.showDialog(
            contentType: DialogContentType.success,
            title: 'Success',
            message: 'Order placed successfully',
            autoDismiss: true);
        Future.delayed(const Duration(seconds: 3), () {
          navigationHandler.pushNamed(homeViewRoute);
        });
      } else {
        log(res.error!.message);
        showSnackbar("Error", res.error!.message, Colors.red, scaffoldKey);
      }

      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);
      toggleLoading(false);
    }
  }
}


