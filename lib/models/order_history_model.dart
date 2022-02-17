// To parse this JSON data, do
//
//     final orderModel = orderModelFromMap(jsonString);
import 'dart:convert';

OrderHistoryModel orderModelFromMap(String str) =>
    OrderHistoryModel.fromMap(json.decode(str));

String orderModelToMap(OrderHistoryModel data) => json.encode(data.toMap());

class OrderHistoryModel {
  OrderHistoryModel({
    required this.orders,
  });

  final List<Order> orders;

  factory OrderHistoryModel.fromMap(Map<String, dynamic> json) =>
      OrderHistoryModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
      };
}

class Order {
  Order({
    required this.id,
    required this.userWears,
    required this.price,
    required this.deliveryFee,
    required this.netPrice,
    required this.paymentMethod,
    required this.paymentRef,
    required this.origin,
    required this.destination,
    required this.currentLocation,
    required this.deliveryMode,
    required this.status,
    required this.orderNo,
    required this.assignedTo,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
  });

  final String id;
  final List<UserWear> userWears;
  final DeliveryFee price;
  final DeliveryFee deliveryFee;
  final DeliveryFee netPrice;
  final String paymentMethod;
  final PaymentRef paymentRef;
  final CurrentLocation origin;
  final CurrentLocation destination;
  final CurrentLocation currentLocation;
  final String deliveryMode;
  final String status;
  final String orderNo;
  final String assignedTo;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"] ?? '',
        userWears: List<UserWear>.from(
            json["userWears"].map((x) => UserWear.fromMap(x))),
        price: DeliveryFee.fromMap(json["price"] ?? ''),
        deliveryFee: DeliveryFee.fromMap(json["deliveryFee"] ?? ''),
        netPrice: DeliveryFee.fromMap(json["netPrice"] ?? ''),
        paymentMethod: json["paymentMethod"] ?? '',
        paymentRef: PaymentRef.fromMap(json["paymentRef"] ?? ''),
        origin: CurrentLocation.fromMap(json["origin"] ?? ''),
        destination: CurrentLocation.fromMap(json["destination"] ?? ''),
        currentLocation: CurrentLocation.fromMap(json["currentLocation"] ?? ''),
        deliveryMode: json["deliveryMode"] ?? '',
        status: json["status"] ?? '',
        orderNo: json["orderNo"] ?? '',
        assignedTo: json["assignedTo"] ?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
        createdBy: json["createdBy"] ?? '',
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userWears": List<dynamic>.from(userWears.map((x) => x.toMap())),
        "price": price.toMap(),
        "deliveryFee": deliveryFee.toMap(),
        "netPrice": netPrice.toMap(),
        "paymentMethod": paymentMethod,
        "paymentRef": paymentRef.toMap(),
        "origin": origin.toMap(),
        "destination": destination.toMap(),
        "currentLocation": currentLocation.toMap(),
        "deliveryMode": deliveryMode,
        "status": status,
        "orderNo": orderNo,
        "assignedTo": assignedTo,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class CurrentLocation {
  CurrentLocation({
    required this.address,
    required this.state,
    required this.lat,
    required this.lng,
  });

  final String address;
  final String state;
  final double lat;
  final double lng;

  factory CurrentLocation.fromMap(Map<String, dynamic> json) => CurrentLocation(
        address: json["address"],
        state: json["state"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "state": state,
        "lat": lat,
        "lng": lng,
      };
}

class DeliveryFee {
  DeliveryFee({
    required this.currency,
    required this.amount,
  });

  final String currency;
  final int amount;

  factory DeliveryFee.fromMap(Map<String, dynamic> json) => DeliveryFee(
        currency: json["currency"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "currency": currency,
        "amount": amount,
      };
}

class PaymentRef {
  PaymentRef();

  factory PaymentRef.fromMap(Map<String, dynamic> json) => PaymentRef();

  Map<String, dynamic> toMap() => {};
}

class UserWear {
  UserWear({
    required this.wearType,
    required this.wearColor,
    required this.wearTotal,
    required this.price,
    required this.serviceType
  });

  final String wearType;
  final List<int> wearColor;
  final int wearTotal;
  final DeliveryFee price;
  final String serviceType;

  factory UserWear.fromMap(Map<String, dynamic> json) => UserWear(
        wearType: json["wearType"],
        serviceType: json["serviceType"],
        wearColor: List<int>.from(
          (json["wearColor"] ?? []),
        ),
        wearTotal: json["wearTotal"],
        price: DeliveryFee.fromMap(json["price"]),
      );

  Map<String, dynamic> toMap() => {
        "wearType": wearType,
        "wearColor": wearColor,
        "wearTotal": wearTotal,
        "price": price.toMap(),
      };
}
