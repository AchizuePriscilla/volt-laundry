// To parse this JSON data, do
//
//     final chatModel = chatModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChatModel chatModelFromMap(String str) => ChatModel.fromMap(json.decode(str));

String chatModelToMap(ChatModel data) => json.encode(data.toMap());

class ChatModel {
    ChatModel({
        required this.messages,
    });

    final List<Message> messages;

    factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        messages: List<Message>.from(json["messages"].map((x) => Message.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toMap())),
    };
}

class Message {
    Message({
        required this.id,
        required this.from,
        required this.to,
        required this.content,
        required this.type,
        required this.createdAt,
    });

    final String id;
    final String from;
    final String to;
    final String content;
    final String type;
    final DateTime createdAt;

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        content: json["content"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "from": from,
        "to": to,
        "content": content,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
    };
}
