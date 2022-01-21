import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:volt/models/api/api.dart';
import 'package:volt/models/chat_model.dart';

class SendChatResponse extends Equatable {
  final bool success;
  final String message;
  final ApiErrorResponse? error;
  final String chatId;

  const SendChatResponse(
      {this.success = false, this.message = '', this.error, this.chatId = ''});

  factory SendChatResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => SendChatResponse(error: failure.error),
      (success) => SendChatResponse(
          success: true,
          message: success.data['message'] ?? "",
          chatId: success.data['chatID']),
    );
  }

  @override
  List<Object?> get props => [success, message, error, chatId];
}

class GetChatResponse extends Equatable{
  final bool success;
  final ChatModel? chat;
  final ApiErrorResponse? error;
  const GetChatResponse({
    this.success = false,
    this.error,
    this.chat,
  });

  factory GetChatResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => GetChatResponse(error: failure.error),
      (success) => GetChatResponse(
        success: true,
        chat: ChatModel.fromMap(success.data),
      ),
    );
  }

  @override
  List<Object?> get props => [
        success,
        error,
        chat
      ];
}
