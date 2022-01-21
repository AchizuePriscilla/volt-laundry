import 'package:volt/models/api/chat_requests.dart';
import 'package:volt/models/api/chat_responses.dart';
import 'package:volt/models/api/general_request.dart';

abstract class ChatRepository {
  Future<SendChatResponse> sendMessage(SendChatRequest request);
  Future<GetChatResponse> getMessages(GeneralRequest request);
}
