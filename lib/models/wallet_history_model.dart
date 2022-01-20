// To parse this JSON data, do
//
//     final walletHistoryModel = walletHistoryModelFromMap(jsonString);
import 'dart:convert';

WalletHistoryModel walletHistoryModelFromMap(String str) => WalletHistoryModel.fromMap(json.decode(str));

String walletHistoryModelToMap(WalletHistoryModel data) => json.encode(data.toMap());

class WalletHistoryModel {
    WalletHistoryModel({
        required this.history,
    });

    final List<History> history;

    factory WalletHistoryModel.fromMap(Map<String, dynamic> json) => WalletHistoryModel(
        history: List<History>.from(json["history"].map((x) => History.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "history": List<dynamic>.from(history.map((x) => x.toMap())),
    };
}

class History {
    History({
        required this.id,
        required this.userId,
        required this.amount,
        required this.description,
        required this.createdAt,
        required this.transactionType,
        required this.transactionRef,
    });

    final String id;
    final String userId;
    final Amount amount;
    final String description;
    final DateTime createdAt;
    final String transactionType;
    final TransactionRef transactionRef;

    factory History.fromMap(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["userID"],
        amount: Amount.fromMap(json["amount"]),
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        transactionType: json["transactionType"],
        transactionRef: TransactionRef.fromMap(json["transactionRef"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userID": userId,
        "amount": amount.toMap(),
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "transactionType": transactionType,
        "transactionRef": transactionRef.toMap(),
    };
}

class Amount {
    Amount({
        required this.currency,
        required this.amount,
    });

    final String currency;
    final double amount;

    factory Amount.fromMap(Map<String, dynamic> json) => Amount(
        currency: json["currency"],
        amount: json["amount"],
    );

    Map<String, dynamic> toMap() => {
        "currency": currency,
        "amount": amount,
    };
}

class TransactionRef {
    TransactionRef();

    factory TransactionRef.fromMap(Map<String, dynamic> json) => TransactionRef(
    );

    Map<String, dynamic> toMap() => {
    };
}
