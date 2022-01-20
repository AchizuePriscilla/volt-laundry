// To parse this JSON data, do
//
//     final processOrderModel = processOrderModelFromMap(jsonString);
import 'dart:convert';

ProcessOrderModel processOrderModelFromMap(String str) => ProcessOrderModel.fromMap(json.decode(str));

String processOrderModelToMap(ProcessOrderModel data) => json.encode(data.toMap());

class ProcessOrderModel {
    ProcessOrderModel({
        required this.serviceType,
        required this.deliveryMode,
        required this.userWears,
        required this.price,
        required this.deliveryFee,
        required this.paymentMethod,
        required this.origin,
        required this.destination,
        required this.currentLocation,
        required this.status,
        required this.paymentRef,
    });

    final String serviceType;
    final String deliveryMode;
    final List<UserWear> userWears;
    final DeliveryFee price;
    final DeliveryFee deliveryFee;
    final String paymentMethod;
    final CurrentLocation origin;
    final CurrentLocation destination;
    final CurrentLocation currentLocation;
    final String status;
    final PaymentRef paymentRef;

    factory ProcessOrderModel.fromMap(Map<String, dynamic> json) => ProcessOrderModel(
        serviceType: json["serviceType"],
        deliveryMode: json["deliveryMode"],
        userWears: List<UserWear>.from(json["userWears"].map((x) => UserWear.fromMap(x))),
        price: DeliveryFee.fromMap(json["price"]),
        deliveryFee: DeliveryFee.fromMap(json["deliveryFee"]),
        paymentMethod: json["paymentMethod"],
        origin: CurrentLocation.fromMap(json["origin"]),
        destination: CurrentLocation.fromMap(json["destination"]),
        currentLocation: CurrentLocation.fromMap(json["currentLocation"]),
        status: json["status"],
        paymentRef: PaymentRef.fromMap(json["paymentRef"]),
    );

    Map<String, dynamic> toMap() => {
        "serviceType": serviceType,
        "deliveryMode": deliveryMode,
        "userWears": List<dynamic>.from(userWears.map((x) => x.toMap())),
        "price": price.toMap(),
        "deliveryFee": deliveryFee.toMap(),
        "paymentMethod": paymentMethod,
        "origin": origin.toMap(),
        "destination": destination.toMap(),
        "currentLocation": currentLocation.toMap(),
        "status": status,
        "paymentRef": paymentRef.toMap(),
    };
}

class CurrentLocation {
    CurrentLocation({
        required this.address,
        required this.lat,
        required this.lng,
    });

    final String address;
    final double lat;
    final double lng;

    factory CurrentLocation.fromMap(Map<String, dynamic> json) => CurrentLocation(
        address: json["address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "address": address,
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

    factory PaymentRef.fromMap(Map<String, dynamic> json) => PaymentRef(
    );

    Map<String, dynamic> toMap() => {
    };
}

class UserWear {
    UserWear({
        required this.wearType,
        required this.wearColor,
        required this.wearTotal,
        required this.price,
    });

    final String wearType;
    final List wearColor;
    final int wearTotal;
    final DeliveryFee price;

    factory UserWear.fromMap(Map<String, dynamic> json) => UserWear(
        wearType: json["wearType"],
        wearColor: json["wearColor"],
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