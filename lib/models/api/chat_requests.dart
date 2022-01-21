import 'package:equatable/equatable.dart';

class SendChatRequest extends Equatable{
  final String message;
  final String type;
  const SendChatRequest({required this.message, this.type = 'text'});
  Map<String, dynamic> toMap() {
    return {
      'content': message,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [message, type];
}

